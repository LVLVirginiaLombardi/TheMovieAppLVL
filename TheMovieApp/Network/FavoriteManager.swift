//
//  FavoriteManager.swift
//  TheMovieApp
//
//  Created by Virginia Lombardi on 18/8/24.
//

import Foundation
import CoreData

class FavoriteManager {
    static let shared = FavoriteManager()
    
    private init() {}
    
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritesModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveFavorite(movie: DataMovie) {
        let favorite = Favorite(context: context)
        favorite.id = Int64(movie.id ?? 0)
        favorite.title = movie.title
        favorite.posterPath = movie.poster_path
        
        do {
            try context.save()
        } catch {
            print("Failed to save favorite: \(error)")
        }
    }
    
    func fetchFavorites() -> [Favorite] {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }
    
    func deleteFavorite(movie: DataMovie) {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", movie.id ?? 0)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let favorite = results.first {
                context.delete(favorite)
                try context.save()
            }
        } catch {
            print("Failed to delete favorite: \(error)")
        }
    }
}
