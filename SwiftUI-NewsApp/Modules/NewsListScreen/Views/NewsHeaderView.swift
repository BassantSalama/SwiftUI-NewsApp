//
//  NewsHeaderView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

// MARK: - NewsHeaderView
struct NewsHeaderView: View {
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 10) {
            
            // MARK: - Top Row
            HStack {
                
                // MARK: - Profile Image
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                
                // MARK: - Title & Subtitle
                VStack(alignment: .leading, spacing: 2) {
                    Text("Basant")
                        .font(.headline)
                        .bold()
                    Text("Explore World News")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // MARK: - Search Icon
                Image(systemName: "magnifyingglass")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            
            // MARK: - Divider
            Divider()
                .background(Color.gray.opacity(0.3))
                .padding(10)
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}
