//
//  ArticleListModel.swift
//  Articles
//
//  Created by Gursewak Singh on 29/10/24.
//
import Foundation

// Root response model
struct ArticlesListResponse: Codable {
    let status: String
    let totalResults: Int
    var articles: [Article]
    
    // Computed property to check if the status is "ok"
    var isSuccess: Bool {
        return status.lowercased() == "ok"
    }
}

// Article model for each article in the array
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

// Source model within each article
struct Source: Codable {
    let id: String?
    let name: String
}
