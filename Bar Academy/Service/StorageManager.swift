//
//  StorageManager.swift
//  Bar Academy
//
//  Created by Anton Duplin on 13/9/22.
//

import Foundation
class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let cocktailKey = "newCocktailList"
    
    private init() {}
    
    func save(cocktail: MakeCocktails) {
        var cocktails = fetchCocktails()
        cocktails.append(cocktail)
        guard let data = try? JSONEncoder().encode(cocktails) else { return }
        userDefaults.set(data, forKey: cocktailKey)
    }
    
   func fetchCocktails() -> [MakeCocktails] {
       guard let data = userDefaults.object(forKey: cocktailKey) as? Data else { return [] }
       guard let cocktails = try? JSONDecoder().decode([MakeCocktails].self, from: data) else { return [] }
       return cocktails
    }
    
    
    
    
    
    func changeFavoriteStatus(at index: Int) {
        var cocktails = fetchCocktails()
        let cocktail = cocktails.remove(at: index)
        //cocktail.favoriteStatus.toggle()
        cocktails.insert(cocktail, at: index)
        
        guard let data = try? JSONEncoder().encode(cocktails) else { return }
        userDefaults.set(data, forKey: cocktailKey)
        
    }
    
}
