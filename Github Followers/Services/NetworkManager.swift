//
//  NetworkManager.swift
//  Github Followers
//
//  Created by Muhammad Afif Maruf on 29/01/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, completion: @escaping ([FollowerModel]?, String?) -> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completion(nil, "This username created invalid request.")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            if let _ = err {
                completion(nil, "Unable to complete your request")
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, "Invalid response from the server")
                return
            }
            
            guard let data = data else {
                completion(nil, "The data received from server not valid")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([FollowerModel].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, "The data received from server not valid")
            }
        }
        
        task.resume()
    }
}
