//
//  FavoritesViewModel.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation

class FavoritesViewModel: ObservableObject {
    @Published var favoriteMovies: [DataMovie] = []
    
    private let movieService = MovieService.shared
    
    func loadFavoriteMovies() {
        let favoriteIds = FavoriteManager.shared.getFavorites()
        let dispatchGroup = DispatchGroup()
        
        var movies: [DataMovie] = []
        
        for id in favoriteIds {
            dispatchGroup.enter()
            movieService.getMovieById(id) { movie in
                if let movie = movie {
                    movies.append(movie)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.favoriteMovies = movies
        }
    }
    
    func removeFavorite(movie: DataMovie) {
        guard let movieId = movie.id else { return }
        FavoriteManager.shared.deleteFavorite(movie: movie)
        loadFavoriteMovies()
    }
}
