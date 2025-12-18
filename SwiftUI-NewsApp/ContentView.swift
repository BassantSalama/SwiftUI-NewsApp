//
//  ContentView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//

import SwiftUI

// MARK: - ContentView (Simplified for ListView phase)
struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var newsVM = NewsViewModel()
    
    // MARK: - Body
    var body: some View {
        TabView {
            
            // MARK: - News Tab
            NewsListView(vm: newsVM)
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            // MARK: - Favorites Placeholder
            VStack {
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                Text("Favorites will be available later")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .tabItem {
                Label("Favorites", systemImage: "star.fill")
            }
            
        }
    }
}

// MARK: - Previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
