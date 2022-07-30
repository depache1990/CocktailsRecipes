//
//  NetworkManager.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?,with complition: @escaping(Cocktails) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else { return }
            do{
                let cocktailsBar = try JSONDecoder().decode(Cocktails.self, from: data)
                DispatchQueue.main.async {
                    complition(cocktailsBar)
                }
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
}

class ImageManager {
    static var shared = ImageManager()

    private init() {}

    func fetchImage(from url: URL, complition: @escaping (Data, URLResponse) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }

            guard url == response.url else { return }

            complition(data, response)

        }.resume()
    }
}



