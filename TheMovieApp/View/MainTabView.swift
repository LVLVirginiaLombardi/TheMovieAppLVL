//
//  MainTabView.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MoviesView()
                .tabItem {
                    Image(systemName: "play.house")
                }
            
            SearchMoviesView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            FavoritesView()
                .tabItem {
                    Image(systemName: "suit.heart")
                }
        }
    }
}

#Preview {
    MainTabView()
}

