//
//  MainTabView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import SwiftUI

struct MainTabView: View {
    init() {
        let appearance = UITabBarAppearance()
        
        // Configure appearance for selected items
        appearance.selectionIndicatorTintColor = UIColor.purple
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.purple]
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.purple
        
        // Configure appearance for unselected items
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Image(systemName: "play.house")
                    Text("Movies")
                }
            
            SearchMoviesView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "suit.heart")
                    Text("Favorites")
                }
        }
    }
}

#Preview {
    MainTabView()
}

