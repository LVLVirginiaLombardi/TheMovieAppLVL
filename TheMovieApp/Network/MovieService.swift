//
//  MovieService.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation

class MovieService {
    static let shared = MovieService()
    
    private init() {}
    
    func getMovieById(_ id: Int, completion: @escaping (DataMovie?) -> Void) {
        let apiKey = "d3dbf6a8b8b0fb451dfc42b75109a398"
        let urlString = "https://api.themoviedb.org/3/movie/\(id)?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let movie = try JSONDecoder().decode(DataMovie.self, from: data)
                completion(movie)
            } catch {
                print("Failed to decode movie data: \(error)")
                completion(nil)
            }
        }.resume()
    }
}

