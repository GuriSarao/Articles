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
    @IBOutlet weak var txt_search: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_search.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        NetworkManager.shared.currentViewController = self
        viewModel.getArticles { status in
            if status {
                self.tbl_article.reloadData()
            }
        }
        setupTableArticles()
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
           if let text = textField.text {
               print("User typed: \(text)")
               if text.isEmpty {
                   viewModel.apiResponse = viewModel.mainApiResponse
               }else {
                   viewModel.apiResponse?.articles = viewModel.mainApiResponse?.articles.filter({ article in
                       article.title.lowercased().contains(text.lowercased())
                   }) ?? []

               }
               self.tbl_article.reloadData()
           }
       }
    
    
    private func setupTableArticles() {
        tbl_article.register(ArticlesListCell.nib, forCellReuseIdentifier: ArticlesListCell.identifier)
        tbl_article.estimatedRowHeight = 44
        tbl_article.rowHeight = UITableView.automaticDimension
    }


    @IBAction func tap_search() {
        if txt_search.isHidden {
            txt_search.isHidden = false
        }else {
            txt_search.isHidden = true
        }
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


