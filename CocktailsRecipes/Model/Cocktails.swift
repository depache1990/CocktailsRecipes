//
//  Cocktails.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import Foundation

struct Cocktails: Decodable {
    var drinks: [Drink]
}


struct Drink: Decodable {
    let strDrink: String
    let strDrinkThumb: String
    let idDrink: String
    let strAlcoholic: String
    
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
   
}

struct DataApi {
    var url: String
    var alphaBet: [String]
    var alphaBetIndex: Int
    var isFetching: Bool
    
    var urlString: String
    
    static func getDataApi () -> DataApi {
        DataApi(
            url: DataManager.shared.cocktailsRecipes,
            alphaBet: DataManager.shared.alphabet,
            alphaBetIndex: DataManager.shared.alphaBetIndex,
            isFetching: DataManager.shared.isFetching,
            urlString: DataManager.shared.urlString
        )
        
    }
}



