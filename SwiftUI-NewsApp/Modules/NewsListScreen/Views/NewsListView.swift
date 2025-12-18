//
//  NewsListView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

// MARK: - NewsListView (Simplified)
struct NewsListView: View {
    
    // MARK: - Properties
    @StateObject var vm: NewsViewModel
    
    // MARK: - Initializer
    init(vm: NewsViewModel = NewsViewModel()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                
                VStack(spacing: 18) {
                    
                    // MARK: - Header
                    NewsHeaderView()
                        .padding(.bottom, 8)
                    
                    // MARK: - Offline Banner
                    if vm.isOffline {
                        OfflineBannerView()
                    }
                    
                    // MARK: - Loading Indicator
                    if vm.isLoading {
                        ProgressView()
                            .scaleEffect(1.5)
                            .padding()
                    }
                    
                    // MARK: - Articles List
                    ForEach(vm.articles) { article in
                        ArticleCardView(article: article)
                    }
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
            .onAppear {
                vm.fetchTopHeadlines()
            }
        }
    }
}

// MARK: - Previews
struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockArticles = [
            Article(title: "Sample News 1",
                    url: "https://example.com/news1",
                    urlToImage: "https://via.placeholder.com/150",
                    publishedAt: "2025-12-16",
                    content: "Sample content 1"),
            Article(title: "Sample News 2",
                    url: "https://example.com/news2",
                    urlToImage: "https://via.placeholder.com/150",
                    publishedAt: "2025-12-16",
                    content: "Sample content 2")
        ]
        
        let vm = NewsViewModel()
        vm.articles = mockArticles
        
        return NewsListView(vm: vm)
    }
}
