//
//  NetworkManager.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import Foundation

var alphaBetIndex = 0
let alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
var urlString = ""

class NetworkManager {

    static let shared = NetworkManager()
    
    private init() {}

    func fetchData(_ complition: @escaping(Cocktails) -> Void) {
        let jsonURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
        urlString = jsonURL + alphabet[alphaBetIndex]
        
        alphaBetIndex += 1
        guard let url = URL(string: urlString) else { return }
        
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



