//
//  FavoriteManager.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation

class FavoriteManager {
    static let shared = FavoriteManager()
    
    private let favoritesKey = "favoriteMovies"
    
    private init() {}
    
    func saveFavorite(movie: DataMovie) {
        guard let movieId = movie.id else {
            print("Movie ID is nil, cannot save favorite")
            return
        }
        
        var favorites = getFavorites()
        if !favorites.contains(movieId) {
            favorites.append(movieId)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }
    
    func getFavorites() -> [Int] {
        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
    }
    
    func isFavorite(movie: DataMovie) -> Bool {
        guard let movieId = movie.id else {
            print("Movie ID is nil, cannot check favorite")
            return false
        }
        
        return getFavorites().contains(movieId)
    }
    
    func deleteFavorite(movie: DataMovie) {
        guard let movieId = movie.id else {
            print("Movie ID is nil, cannot delete favorite")
            return
        }
        
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: movieId) {
            favorites.remove(at: index)
            UserDefaults.standard.set(favorites, forKey: favoritesKey)
        }
    }
    
    func clearFavorites() {
        UserDefaults.standard.removeObject(forKey: favoritesKey)
    }
}

