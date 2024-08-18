//
//  NetworkManager.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 17/8/24.
//


import UIKit

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
    case decodingError
}

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    private let cache = NSCache<NSString, UIImage>()
    
    static let apiKey = "d3dbf6a8b8b0fb451dfc42b75109a398"
    
    static let upcoming = "https://api.themoviedb.org/3/movie/upcoming?api_key=\(apiKey)"
    static let nowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)"
    static let trending = "https://api.themoviedb.org/3/trending/all/day?api_key=\(apiKey)"
    static let popular = "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)"
    static let topRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)"
    
    
//    func saveImage(_ image: UIImage, withName name: String) {
//        guard let data = image.pngData() else { return }
//        let filename = getDocumentsDirectory().appendingPathComponent(name)
//        try? data.write(to: filename)
//    }
//
//    func loadImage(withName name: String) -> UIImage? {
//        let filename = getDocumentsDirectory().appendingPathComponent(name)
//        return UIImage(contentsOfFile: filename.path)
//    }
//
//    func getDocumentsDirectory() -> URL {
//        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//    }
//
//    func downloadAndSaveImage(from url: URL, withName name: String, completion: @escaping (UIImage?) -> Void) {
//        let cacheKey = url.absoluteString as NSString
//        if let cachedImage = cache.object(forKey: cacheKey) {
//            completion(cachedImage)
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, _, error in
//            if let _ = error {
//                completion(nil)
//                return
//            }
//            
//            guard let data = data, let image = UIImage(data: data) else {
//                completion(nil)
//                return
//            }
//            
//            self.cache.setObject(image, forKey: cacheKey)
//            self.saveImage(image, withName: name)
//            completion(image)
//        }.resume()
//    }
    
    func getPopularMovies(completed: @escaping (Result<[DataMovie], APError>) -> Void) {
        guard let url = URL(string: "\(NetworkManager.popular)&language=en-US") else {
            completed(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[DataMovie], APError>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=d3dbf6a8b8b0fb451dfc42b75109a398") else {
            completion(.failure(.invalidURL))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unableToComplete))
                print("Debug: \(error.localizedDescription)")
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completion(.success(decodedResponse.results))
            } catch {
                print("Debug: Decoding error \(error.localizedDescription)")
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }


    func getLisOfUpcomingMovies(numPage: Int, completed: @escaping (Result<MovieDataModel, APError>) -> Void) {
        guard let url = URL(string: "\(NetworkManager.upcoming)&page=\(numPage)") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func getMoviesNowPlaying(completed: @escaping (Result<[DataMovie], APError>) -> Void) {
        guard let url = URL(string: "\(NetworkManager.nowPlaying)&language=en-US") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
//    func getMoviesTrending(completed: @escaping (Result<[DataMovie], APError>) -> Void) {
//        guard let url = URL(string: "\(NetworkManager.trending)&language=en-US") else {
//            completed(.failure(.invalidURL))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _ = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//            
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
//                completed(.success(decodedResponse.results))
//            } catch {
//                print("Debug: decoding error \(error.localizedDescription)")
//                completed(.failure(.decodingError))
//            }
//        }
//        task.resume()
//    }
    
    func getListOfTrailers(id: Int, completed: @escaping (Result<[Trailer], APError>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=\(NetworkManager.apiKey)") else {
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(TrailerResponse.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    func searchMovies(name: String, completed: @escaping (Result<[DataMovie], APError>) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(NetworkManager.apiKey)&language=en-US&page=1&include_adult=false&query=\(name)") else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(MovieDataModel.self, from: data)
                completed(.success(decodedResponse.results))
            } catch {
                print("Debug: error \(error.localizedDescription)")
                completed(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
