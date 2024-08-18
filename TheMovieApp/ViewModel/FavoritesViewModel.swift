//
//  FavoritesViewModel.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []

    func loadFavorites() {
        self.favorites = FavoriteManager.shared.fetchFavorites()
    }
}
