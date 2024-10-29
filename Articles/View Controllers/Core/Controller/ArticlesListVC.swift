//
//  ViewController.swift
//  Articles
//
//  Created by Gursewak Singh on 28/10/24.
//

import UIKit
import Cache
class ArticlesListVC: UIViewController {
    
let viewModel = ArticlesListViewModel()
    
    //MARK: - Outlets
    @IBOutlet weak var tbl_article: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getArticles { status in
            if status {
                self.tbl_article.reloadData()
            }
        }
        setupTableArticles()
    }
    
    private func setupTableArticles() {
        tbl_article.register(ArticlesListCell.nib, forCellReuseIdentifier: ArticlesListCell.identifier)
        tbl_article.estimatedRowHeight = 44
        tbl_article.rowHeight = UITableView.automaticDimension
    }


}


extension ArticlesListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.apiResponse?.articles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesListCell.identifier, for: indexPath) as? ArticlesListCell else { return UITableViewCell() }
        cell.img_article.tag = indexPath.row
        if let article = viewModel.apiResponse?.articles[indexPath.row] {
            cell.configureCell(article: article)
        }
            return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ArticleDetailsVC") as? ArticleDetailsVC else {
            return
        }
        vc.title_text = viewModel.apiResponse?.articles[indexPath.row].title ?? ""
        vc.date = viewModel.apiResponse?.articles[indexPath.row].publishedAt.toFormattedDateString() ?? ""
        vc.description_text = viewModel.apiResponse?.articles[indexPath.row].description ?? ""
        vc.img = viewModel.apiResponse?.articles[indexPath.row].urlToImage ?? ""
        
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


//class ArticlesListViewModel {
//    @Published var apiResponse: ArticlesListResponse?
//
//    func getArticles(completionHandler: @escaping(_ status: Bool) -> ()) {
//        AlamofireHelper.getRequest(withUrl: API.GET_ARTICLES) { data, error in
//            guard let data = data, error == nil else {
//                print("Request failed with error:", error!)
//                completionHandler(false)
//                return
//            }
//            do {
//                    let response = try JSONDecoder().decode(ArticlesListResponse.self, from: data)
//                    
//                    if response.isSuccess {
//                        self.apiResponse = response
//                        completionHandler(true)
//
//                        print("Request succeeded with \(response.articles.count) articles.")
//                    } else {
//                        completionHandler(false)
//
//                        print("Request did not succeed. Status: \(response.status)")
//                    }
//                } catch {
//                    completionHandler(false)
//
//                    print("Failed to decode JSON:", error)
//                }
//        }
//    }
//}

import Cache
import Alamofire


class ArticlesListViewModel {
    @Published var apiResponse: ArticlesListResponse?

    // Create a cache instance
    private var cache: Storage<String, ArticlesListResponse>?
    
    init() {
        // Initialize the cache
        let diskConfig = DiskConfig(name: "ArticlesCache")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 100, totalCostLimit: 0)
        
        do {
            // Make sure to specify the type of the transformer
            cache = try Storage<String, ArticlesListResponse>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: ArticlesListResponse.self) // Correctly specify the type here
            )
        } catch {
            print("Failed to initialize cache:", error)
        }
    }

    func getArticles(completionHandler: @escaping (_ status: Bool) -> ()) {
        // Check if the articles are already cached
        do {
            if let cachedResponse = try cache?.object(forKey: "articles") {
                // If cached, set the apiResponse and call completionHandler
                self.apiResponse = cachedResponse
                completionHandler(true)
                print("Loaded articles from cache with \(cachedResponse.articles.count) articles.")
                return
            }
        } catch {
            print("Failed to fetch cached articles:", error)
        }
        
        // If not cached, proceed with the network request
        AlamofireHelper.getRequest(withUrl: API.GET_ARTICLES) { data, error in
            guard let data = data, error == nil else {
                print("Request failed with error:", error!)
                completionHandler(false)
                return
            }
            do {
                let response = try JSONDecoder().decode(ArticlesListResponse.self, from: data)
                
                if response.isSuccess {
                    // Cache the response
                    do {
                        try self.cache?.setObject(response, forKey: "articles") // Use setObject to store in cache
                        print("Articles cached successfully.")
                    } catch {
                        print("Failed to cache articles:", error)
                    }
                    
                    self.apiResponse = response
                    completionHandler(true)
                    print("Request succeeded with \(response.articles.count) articles.")
                } else {
                    completionHandler(false)
                    print("Request did not succeed. Status: \(response.status)")
                }
            } catch {
                completionHandler(false)
                print("Failed to decode JSON:", error)
            }
        }
    }
}
