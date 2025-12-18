//
//  NewsViewModel.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

class NewsViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var articles: [Article] = []
    @Published var errorMessage: String?
    @Published var isOffline: Bool = false
    @Published var isLoading: Bool = false
    
    // MARK: - Private Properties
    private let networkMonitor: NetworkMonitor
    
    // MARK: - Initializer
    init(networkMonitor: NetworkMonitor = NetworkMonitor()) {
        self.networkMonitor = networkMonitor
        
        networkMonitor.$isConnected
            .receive(on: DispatchQueue.main)
            .map { !$0 }
            .assign(to: &$isOffline)
    }
    
    // MARK: - Public Methods
    
    /// Fetch top headlines from NewsAPI
    func fetchTopHeadlines() {
        guard !isOffline else { return }
        
        guard let url = URL(string: NewsAPI.Endpoint.topHeadlinesUS) else {
            errorMessage = "Invalid URL"
            return
        }
        
        let request = APIRequestBuilder(url: url)
            .setMethod(.GET)
            .build()
        
        isLoading = true
        
        NetworkManager.shared.request(request) { (result: Result<NewsResponse, APIError>) in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let response):
                    self.articles = response.articles
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
}
