//
//  NetworkManager.swift
//  FetchRewardsCodingExercise
//
//  Created by Collin Browse on 1/7/21.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    let cache = NSCache<NSString, UIImage>()
    
    
    private init() {}
    
    
    func getEvents(completed: @escaping (Result<[Event], FetchError>) -> Void) {
        
        let endpoint = NetworkConstants.seatGeekAPI + NetworkConstants.eventsEndpoint + "?client_id=\(NetworkConstants.clientID)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
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
                let events = try decoder.decode(Events.self, from: data)
                completed(.success(events.events))
            } catch let error {
                if let decodingError = error as? DecodingError {
                    print(decodingError)
                }
                completed(.failure(.invalidData))
            }
             
        }
        task.resume()
    }
    
    
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completed(image)
        }
        task.resume()
    }
    
}
