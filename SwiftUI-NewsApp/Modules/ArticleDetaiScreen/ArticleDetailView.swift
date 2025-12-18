//
//  ArticleDetailView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

// MARK: - ArticleDetailView
struct ArticleDetailView: View {
    
    // MARK: - Properties
    let article: Article
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm: FavoritesViewModel // Passed from parent or created here
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                
                // MARK: - Article Image + Favorite Button
                GeometryReader { geometry in
                    let padding: CGFloat = 20
                    let contentWidth = geometry.size.width - padding * 2
                    
                    ZStack(alignment: .topTrailing) {
                        
                        // Article Image
                        if let urlString = article.urlToImage,
                           let url = URL(string: urlString) {
                            AsyncImage(url: url) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: contentWidth, height: 350)
                                    .clipped()
                                    .cornerRadius(20)
                            } placeholder: {
                                Color.gray
                                    .frame(width: contentWidth, height: 350)
                                    .cornerRadius(20)
                            }
                        }
                        
                        // Favorite Star Button
                        Button {
                            withAnimation(.spring()) {
                                vm.toggleFavorite(article: article)
                            }
                        } label: {
                            Image(systemName: vm.isFavorite(article: article) ? "star.fill" : "star")
                                .foregroundColor(.white)
                                .padding(12)
                                .background(.ultraThinMaterial)
                                .clipShape(Circle())
                        }
                        .padding(.top, 24)
                        .padding(.trailing, 24)
                    }
                    .frame(width: geometry.size.width)
                }
                .frame(height: 350)
                
                // MARK: - Article Content Card
                VStack(alignment: .leading, spacing: 16) {
                    Text(article.title)
                        .font(.title2)
                        .fontWeight(.bold)
                        .lineLimit(nil)
                    
                    Text(article.publishedAt)
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    Divider()
                    
                    Text(article.content ?? "No content available")
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(6)
                }
                .padding(20)
                .background(.white)
                .cornerRadius(24)
                .shadow(color: Color.black.opacity(0.12), radius: 14, x: 0, y: 6)
                .offset(y: -60)
                .frame(maxWidth: UIScreen.main.bounds.width - 40)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 0)
        .background(Color(.systemGroupedBackground))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            
            // MARK: - Toolbar Title
            ToolbarItem(placement: .principal) {
                Text("Details")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.bottom, 6)
            }
            
            // MARK: - Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("News")
                            .fontWeight(.medium)
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }
}

// MARK: - Previews
struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleArticle = Article(
            title: "Sample News Title",
            url: "https://example.com/news1",
            urlToImage: "https://via.placeholder.com/300",
            publishedAt: "2025-12-16",
            content: "This is some sample content for the article detail preview. This is some sample content for the article detail preview. This is some sample content for the article detail preview."
        )
        let vm = FavoritesViewModel() // ViewModel instance for Favorites
        
        ArticleDetailView(article: sampleArticle, vm: vm)
    }
}

