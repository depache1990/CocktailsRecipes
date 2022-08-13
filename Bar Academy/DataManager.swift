//
//  DataManager.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 3/8/22.
//

import Foundation
struct DataManager {
    static let shared = DataManager()
    
    private init() {}
    
    var cocktailsRecipes = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
    var alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    var alphaBetIndex = 0
    var isFetching = false
    var urlString = ""
    
}




