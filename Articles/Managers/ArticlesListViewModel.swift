

//
//  ArticlesListViewModel.swift
//  Articles
//
//  Created by Gursewak Singh on 30/10/24.
//

import Alamofire

class ArticlesListViewModel {
    @Published var apiResponse: ArticlesListResponse?
    var mainApiResponse: ArticlesListResponse?
    private let articlesCache = ArticlesCache() // Use the new cache class
    
    func getArticles(completionHandler: @escaping (_ status: Bool) -> ()) {
        // Check if the articles are already cached
        if let cachedResponse = articlesCache.getCachedArticles() {
            // If cached, set the apiResponse and call completionHandler
            self.apiResponse = cachedResponse
            self.mainApiResponse = cachedResponse
            completionHandler(true)
            print("Loaded articles from cache with \(cachedResponse.articles.count) articles.")
            return
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
                    self.articlesCache.cacheArticles(response) // Use the cache method
                    self.apiResponse = response
                    self.mainApiResponse = response
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
