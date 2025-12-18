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
            List {
                
                // MARK: - Favorite Articles List
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
            .onAppear {
                vm.fetchFavorites()
            }
            .navigationTitle("Favorites")
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
        // Create in-memory persistence
        let previewContext = PersistenceController(inMemory: true).container.viewContext
        
        // Pass it to the ViewModel
        let favVM = FavoritesViewModel(context: previewContext)
        
        FavoritesView(vm: favVM)
    }
}
