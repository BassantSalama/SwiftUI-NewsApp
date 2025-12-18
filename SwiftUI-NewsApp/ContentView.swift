//
//  ContentView.swift
//  SwiftUI-NewsApp
//
//  Created by mac on 18/12/2025.
//
import SwiftUI

// MARK: - ContentView
struct ContentView: View {
    
    // MARK: - Properties
    @StateObject var favVM = FavoritesViewModel()

    // MARK: - Body
    var body: some View {
        TabView {
            
            // MARK: - News Tab
            NewsListView(vm: NewsViewModel(), favVM: favVM)
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }

            // MARK: - Favorites Tab
            FavoritesView(vm: favVM) 
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
