//
//  FavoritesViewModel.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI
import CoreData

class FavoritesViewModel: ObservableObject {
    @Published private(set) var favorites: [FavoriteArticle] = []

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        fetchFavorites()
    }

    // MARK: - Fetch
    func fetchFavorites() {
        let request: NSFetchRequest<FavoriteArticle> = FavoriteArticle.fetchRequest()
        do {
            favorites = try context.fetch(request)
        } catch {
            print("Fetch error: \(error)")
            favorites = []
        }
    }

    // MARK: - Check
    func isFavorite(article: Article) -> Bool {
        favorites.contains { $0.id == article.id }
    }

    // MARK: - Toggle
    func toggleFavorite(article: Article) {
        if isFavorite(article: article) {
            removeFavorite(article: article)
        } else {
            addFavorite(article: article)
        }
    }

    // MARK: - Add
    private func addFavorite(article: Article) {
        let fav = FavoriteArticle(context: context)
        fav.id = article.id
        fav.title = article.title
        fav.url = article.url
        fav.urlToImage = article.urlToImage
        fav.publishedAt = article.publishedAt
        fav.content = article.content

        save()
    }

    // MARK: - Remove
    private func removeFavorite(article: Article) {
        guard let fav = favorites.first(where: { $0.id == article.id }) else { return }
        context.delete(fav)
        save()
    }

    // MARK: - Save
    private func save() {
        do {
            try context.save()
            fetchFavorites()
        } catch {
            print("Save error: \(error)")
            context.rollback()
        }
    }
}

