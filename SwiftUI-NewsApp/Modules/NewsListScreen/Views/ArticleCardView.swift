//
//  ArticleCardView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

struct ArticleCardView: View {
    
    // MARK: - Properties
    let article: Article
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Article Image
            if let imageUrl = article.urlToImage,
               let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.25)
                }
                .frame(height: 170)
                .clipped()
                .cornerRadius(16, corners: [.topLeft, .topRight])
            }
            
            // MARK: - Article Info
            VStack(alignment: .leading, spacing: 8) {
                
                Text(article.title)
                    .font(.system(size: 17, weight: .semibold))
                    .lineLimit(3)
                    .foregroundColor(.primary)
                
                Text(article.publishedAt)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
            }
            .padding(14)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 6, x: 0, y: 4)
    }
}

// MARK: - Previews
struct ArticleCardView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleCardView(article: Article(
            title: "Sample News Title",
            url: "https://example.com/news1",
            urlToImage: "https://via.placeholder.com/150",
            publishedAt: "2025-12-16",
            content: "This is a sample content for preview."
        ))
    }
}
