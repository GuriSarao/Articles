//
//  ArticlesCache.swift
//  Articles
//
//  Created by Gursewak Singh on 30/10/24.
//

import Foundation
import Cache
class ArticlesCache {
    private var cache: Storage<String, ArticlesListResponse>?
    
    init() {
        let diskConfig = DiskConfig(name: "ArticlesCache")
        let memoryConfig = MemoryConfig(expiry: .never, countLimit: 100, totalCostLimit: 0)
        
        do {
            cache = try Storage<String, ArticlesListResponse>(
                diskConfig: diskConfig,
                memoryConfig: memoryConfig,
                transformer: TransformerFactory.forCodable(ofType: ArticlesListResponse.self)
            )
        } catch {
            print("Failed to initialize cache:", error)
        }
    }
    
    func getCachedArticles() -> ArticlesListResponse? {
        do {
            return try cache?.object(forKey: "articles")
        } catch {
            print("Failed to fetch cached articles:", error)
            return nil
        }
    }
    
    func cacheArticles(_ articles: ArticlesListResponse) {
        do {
            try cache?.setObject(articles, forKey: "articles")
            print("Articles cached successfully.")
        } catch {
            print("Failed to cache articles:", error)
        }
    }
}
