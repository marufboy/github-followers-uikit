//
//  PersistenceManager.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 24/02/24.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: FollowerModel, actionType: PersistenceActionType, completion: @escaping (GFErrorMessage?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case.success(let favorites):
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                case.remove:
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                
                completion(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[FollowerModel], GFErrorMessage>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([FollowerModel].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [FollowerModel]) -> GFErrorMessage? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
