//
//  Article.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation

struct NewsResponse: Decodable {
    let articles: [Article]
}

struct Article: Identifiable, Decodable {
    let title: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    
    var id: String { url }
    
    
}
