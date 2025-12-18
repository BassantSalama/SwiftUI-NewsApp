//
//  FavoritesView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

// MARK: - FavoritesView
struct FavoritesView: View {
    
    // MARK: - Properties
    @ObservedObject var vm: FavoritesViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            
            if vm.favorites.isEmpty {
                // MARK: - Empty / Offline Placeholder
                VStack(spacing: 12) {
                    Image(systemName: "star")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                    Text("No Favorites Yet")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Text("Save articles you love to see them here. Enjoy browsing even offline!")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 24)
                }
                .padding(.top, 50)
                
            } else {
                // MARK: - Favorite Articles List
                List {
                    ForEach(vm.favorites, id: \.id) { fav in
                        NavigationLink(destination: ArticleDetailView(article: convertToArticle(fav), vm: vm)) {
                            ArticleCardView(article: convertToArticle(fav))
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete { indexSet in
                        // MARK: - Delete Favorite
                        indexSet.forEach { index in
                            let fav = vm.favorites[index]
                            let article = convertToArticle(fav)
                            vm.toggleFavorite(article: article)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Favorites")
                
            }
        }
        .onAppear {
            vm.fetchFavorites()
        }
        
    }
    
    // MARK: - Helper: Convert CoreData FavoriteArticle to Article
    private func convertToArticle(_ fav: FavoriteArticle) -> Article {
        Article(
            title: fav.title ?? "No Title",
            url: fav.url ?? "",
            urlToImage: fav.urlToImage,
            publishedAt: fav.publishedAt ?? "",
            content: fav.content
        )
    }
}

// MARK: - Previews
struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let previewContext = PersistenceController(inMemory: true).container.viewContext
        let favVM = FavoritesViewModel(context: previewContext)
        FavoritesView(vm: favVM)
    }
}

