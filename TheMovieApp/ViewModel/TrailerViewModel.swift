//
//  TrailerViewModel.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation

class TrailerViewModel: ObservableObject {
    
    @Published var listOfTrailers: [Trailer] = []
    
//    private let favoritesKey = "favorites"
    
//    func toggleFavorite(movie: DataMovie) {
//        var favorites = getFavorites()
//        if let index = favorites.firstIndex(where: { $0.id == movie.id }) {
//            favorites.remove(at: index)
//        } else {
//            favorites.append(movie)
//        }
//        saveFavorites(favorites)
//    }
//    
//    func isFavorite(movie: DataMovie) -> Bool {
//        return getFavorites().contains(where: { $0.id == movie.id })
//    }
//    
//    private func saveFavorites(_ movies: [DataMovie]) {
//        if let encoded = try? JSONEncoder().encode(movies) {
//            UserDefaults.standard.set(encoded, forKey: favoritesKey)
//        }
//    }
//    
//    private func getFavorites() -> [DataMovie] {
//        if let data = UserDefaults.standard.data(forKey: favoritesKey),
//           let decoded = try? JSONDecoder().decode([DataMovie].self, from: data) {
//            return decoded
//        }
//        return []
//    }
    
    func getTrailers(id: Int) {
        NetworkManager.shared.getListOfTrailers(id: id) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                
                switch result {
                case .success(let trailers):
                    self.listOfTrailers = trailers
                
                case .failure(let error):
                    print("Error \(error)")
                }
            }
        }
    }
}
