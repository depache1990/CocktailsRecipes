//
//  CocktailsDetailsViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 30/7/22.
//

import UIKit

class CocktailsDetailsViewController: UIViewController {
    
    @IBOutlet weak var ingredientsLabel: UITextView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var alhoholInfoLabel: UILabel!
    @IBOutlet weak var imageView: CocktailsImageView!{
        didSet{
            imageView.layer.cornerRadius = imageView.frame.height / 3
        }
    }
     var cocktail: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUserInfo()
        createIngrediets()
        title = cocktail.strDrink
        descriptionLabel.text = cocktail.strInstructions
        
        DispatchQueue.main.async {
            self.imageView.fetchImage(from: self.cocktail.strDrinkThumb)
            
        }
    }
 
    private func addIngridients(measure: String?, ingridients: String?) {
        guard measure != nil else { return }
        ingredientsLabel.text! += measure!
        guard ingridients != nil else { return }
        ingredientsLabel.text! += "\(ingridients!)\n"
    }
    
    private func updateUserInfo(){
        alhoholInfoLabel.text = "Alcoholic"
        if cocktail.strAlcoholic != "Alcoholic"{
            alhoholInfoLabel.text = "No"
        }
    }
    private func createIngrediets() {
        ingredientsLabel.text = ""
        addIngridients(measure: cocktail.strMeasure1, ingridients: cocktail.strIngredient1)
        addIngridients(measure: cocktail.strMeasure2, ingridients: cocktail.strIngredient2)
        addIngridients(measure: cocktail.strMeasure3, ingridients: cocktail.strIngredient3)
        addIngridients(measure: cocktail.strMeasure4, ingridients: cocktail.strIngredient4)
        addIngridients(measure: cocktail.strMeasure5, ingridients: cocktail.strIngredient5)
        addIngridients(measure: cocktail.strMeasure6, ingridients: cocktail.strIngredient6)
        addIngridients(measure: cocktail.strMeasure7, ingridients: cocktail.strIngredient7)
        addIngridients(measure: cocktail.strMeasure8, ingridients: cocktail.strIngredient8)
        addIngridients(measure: cocktail.strMeasure9, ingridients: cocktail.strIngredient9)
        addIngridients(measure: cocktail.strMeasure10, ingridients: cocktail.strIngredient10)
        addIngridients(measure: cocktail.strMeasure11, ingridients: cocktail.strIngredient11)
        addIngridients(measure: cocktail.strMeasure12, ingridients: cocktail.strIngredient12)
        addIngridients(measure: cocktail.strMeasure13, ingridients: cocktail.strIngredient13)
        addIngridients(measure: cocktail.strMeasure14, ingridients: cocktail.strIngredient14)
        addIngridients(measure: cocktail.strMeasure15, ingridients: cocktail.strIngredient15)
    }
    
}
