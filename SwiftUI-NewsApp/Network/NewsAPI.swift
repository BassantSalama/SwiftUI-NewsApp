//
//  NewsAPI.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import Foundation

struct NewsAPI {
    static let apiKey = "2fcaca371f9340b894cbe62db9cdb96e"
    
    struct Endpoint {
        static let topHeadlinesUS = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(NewsAPI.apiKey)"
    }
}
