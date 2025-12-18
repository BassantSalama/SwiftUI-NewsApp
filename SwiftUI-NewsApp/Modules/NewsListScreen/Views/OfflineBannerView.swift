//
//  OfflineBannerView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//


import SwiftUI

// MARK: - OfflineBannerView
struct OfflineBannerView: View {
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 6) {
            
            // MARK: - Icon
            Image(systemName: "wifi.slash")
                .font(.title)
                .foregroundColor(.gray)
            
            // MARK: - Title
            Text("You are offline")
                .font(.headline)
            
            // MARK: - Subtitle
            Text("You can still view your saved articles")
                .font(.caption)
                .foregroundColor(.secondary)
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 4)
    }
}

// MARK: - Preview
struct OfflineBannerView_Previews: PreviewProvider {
    static var previews: some View {
        OfflineBannerView()
    }
}
