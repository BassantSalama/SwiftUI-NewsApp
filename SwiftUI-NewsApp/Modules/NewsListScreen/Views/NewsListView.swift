//
//  NewsListView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

// MARK: - NewsListView
struct NewsListView: View {
    
    @StateObject var vm: NewsViewModel
    
    init(vm: NewsViewModel = NewsViewModel()) {
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 18) {
                    
                    // Header
                    NewsHeaderView()
                        .padding(.bottom, 8)
                    
                    // Offline Banner
                    if vm.isOffline {
                        OfflineBannerView()
                    }
                    
                    // Loading Indicator
                    if vm.isLoading {
                        ProgressView()
                            .scaleEffect(1.5)
                            .padding()
                    }
                    
                    // Articles List
                    ForEach(vm.articles) { article in
                        NavigationLink(destination: ArticleDetailView(article: article)) {
                            ArticleCardView(article: article)
                        }
                        .buttonStyle(.plain)
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
