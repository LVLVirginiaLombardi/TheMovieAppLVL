//
//  FavoriteManager.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

//import Foundation
//import SwiftUI
//import CoreData
//
//class FavoriteManager {
//    static let shared = FavoriteManager()
//    private let cache = NSCache<NSString, UIImage>()
//    
//    private init() {}
//    
//    private var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "FavoritesModel")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
//    
//    private var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//    
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
//    func saveFavorite(movie: DataMovie) {
//        let favorite = Favorite(context: context)
//        favorite.id = Int64(movie.id ?? 0)
//        favorite.title = movie.title
//        favorite.posterPath = movie.poster_path
//        
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save favorite: \(error)")
//        }
//    }
//    
//    func fetchFavorites() -> [Favorite] {
//        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        
//        do {
//            return try context.fetch(fetchRequest)
//        } catch {
//            print("Failed to fetch favorites: \(error)")
//            return []
//        }
//    }
//    
//    func deleteFavorite(movie: DataMovie) {
//        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id ?? 0)
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            if let favorite = results.first {
//                context.delete(favorite)
//                try context.save()
//            }
//        } catch {
//            print("Failed to delete favorite: \(error)")
//        }
//    }
//}
//import Foundation
//import SwiftUI
//import CoreData
//
//class FavoriteManager {
//    static let shared = FavoriteManager()
//    private let cache = NSCache<NSString, UIImage>()
//    
//    private init() {}
//    
//    private lazy var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "FavoritesModel")
//        container.loadPersistentStores { _, error in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        }
//        return container
//    }()
//    
//    private var context: NSManagedObjectContext {
//        return persistentContainer.viewContext
//    }
//    
//    // MARK: - Image Management
//    
//    func saveImage(_ image: UIImage, withName name: String) {
//        guard let data = image.pngData() else { return }
//        let url = documentsDirectory.appendingPathComponent(name)
//        do {
//            try data.write(to: url)
//        } catch {
//            print("Failed to save image: \(error)")
//        }
//    }
//    
//    func loadImage(withName name: String) -> UIImage? {
//        let url = documentsDirectory.appendingPathComponent(name)
//        return UIImage(contentsOfFile: url.path)
//    }
//    
//    func downloadAndSaveImage(from url: URL, withName name: String, completion: @escaping (UIImage?) -> Void) {
//        let cacheKey = url.absoluteString as NSString
//        
//        if let cachedImage = cache.object(forKey: cacheKey) {
//            completion(cachedImage)
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
//            guard let self = self, let data = data, let image = UIImage(data: data) else {
//                print("Failed to download or process image: \(error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//                return
//            }
//            
//            self.cache.setObject(image, forKey: cacheKey)
//            self.saveImage(image, withName: name)
//            completion(image)
//        }.resume()
//    }
//    
//    private var documentsDirectory: URL {
//        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//    }
//    
//    // MARK: - Favorite Movies Management
//    
//    func saveFavorite(movie: DataMovie) {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot save favorite")
//            return
//        }
//        
//        if let existingFavorite = fetchFavorite(byId: movieId) {
//            print("Movie is already in favorites")
//            return
//        }
//        
//        let favorite = Favorite(context: context)
//        favorite.id = Int64(movieId)
//        favorite.title = movie.title
//        favorite.posterPath = movie.poster_path
//        
//        saveContext()
//    }
//    
//    func fetchFavorites(completion: @escaping ([Favorite]) -> Void) {
//        executeFetchRequest(Favorite.fetchRequest(), completion: completion)
//    }
//    
//    func deleteFavorite(movie: DataMovie) {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot delete favorite")
//            return
//        }
//        
//        if let favorite = fetchFavorite(byId: movieId) {
//            context.delete(favorite)
//            saveContext()
//        }
//    }
//    
//    // MARK: - Core Data Helper Functions
//    
//    private func saveContext() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                print("Failed to save context: \(error)")
//            }
//        }
//    }
//    
//    private func fetchFavorite(byId movieId: Int) -> Favorite? {
//        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
//        
//        return try? context.fetch(fetchRequest).first
//    }
//    
//    private func executeFetchRequest<T: NSFetchRequestResult>(_ request: NSFetchRequest<T>, completion: @escaping ([T]) -> Void) {
//        DispatchQueue.global(qos: .background).async {
//            let results = (try? self.context.fetch(request)) ?? []
//            DispatchQueue.main.async {
//                completion(results)
//            }
//        }
//    }
//}
//import CoreData
//import SwiftUI
//
//class FavoriteManager {
//    static let shared = FavoriteManager()
//    
//    private let context: NSManagedObjectContext
//    
//    private init(context: NSManagedObjectContext = PersistenceController.shared.viewContext) {
//        self.context = context
//    }
//    
//    func saveFavorite(movie: DataMovie) {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot save favorite")
//            return
//        }
//        
//        let favorite = Favorite(context: context)
//        favorite.id = Int64(movieId)
//        favorite.title = movie.title
//        favorite.posterPath = movie.poster_path
//        
//        do {
//            try context.save()
//        } catch {
//            print("Failed to save favorite: \(error)")
//        }
//    }
//    
//    func fetchFavorites(completion: @escaping ([Favorite]) -> Void) {
//        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        
//        DispatchQueue.global(qos: .background).async {
//            do {
//                let favorites = try self.context.fetch(fetchRequest)
//                DispatchQueue.main.async {
//                    completion(favorites)
//                }
//            } catch {
//                print("Failed to fetch favorites: \(error)")
//                DispatchQueue.main.async {
//                    completion([])
//                }
//            }
//        }
//    }
//    
//    func deleteFavorite(movie: DataMovie) {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot delete favorite")
//            return
//        }
//        
//        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            if let favorite = results.first {
//                context.delete(favorite)
//                try context.save()
//            }
//        } catch {
//            print("Failed to delete favorite: \(error)")
//        }
//    }
//    
//    func isFavorite(movie: DataMovie) -> Bool {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot check favorite")
//            return false
//        }
//        
//        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %d", movieId)
//        
//        do {
//            let count = try context.count(for: fetchRequest)
//            return count > 0
//        } catch {
//            print("Failed to check if movie is favorite: \(error)")
//            return false
//        }
//    }
//}


//import Foundation
//
//class FavoriteManager {
//    static let shared = FavoriteManager()
//    
//    private let favoritesKey = "favoriteMovies"
//    
//    private init() {}
//    
//    func saveFavorite(movie: DataMovie) {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot save favorite")
//            return
//        }
//        
//        var favorites = getFavorites()
//        if !favorites.contains(movieId) {
//            favorites.append(movieId)
//            UserDefaults.standard.set(favorites, forKey: favoritesKey)
//        }
//    }
//    
//    func getFavorites() -> [Int] {
//        return UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
//    }
//    
//    func isFavorite(movie: DataMovie) -> Bool {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot check favorite")
//            return false
//        }
//        
//        return getFavorites().contains(movieId)
//    }
//    
//    func deleteFavorite(movie: DataMovie) {
//        guard let movieId = movie.id else {
//            print("Movie ID is nil, cannot delete favorite")
//            return
//        }
//        
//        var favorites = getFavorites()
//        if let index = favorites.firstIndex(of: movieId) {
//            favorites.remove(at: index)
//            UserDefaults.standard.set(favorites, forKey: favoritesKey)
//        }
//    }
//    
//    func clearFavorites() {
//        UserDefaults.standard.removeObject(forKey: favoritesKey)
//    }
//}

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

