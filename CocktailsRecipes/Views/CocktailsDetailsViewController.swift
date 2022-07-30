//
//  CocktailsDetailsViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 30/7/22.
//

import UIKit

class CocktailsDetailsViewController: UIViewController {
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: CocktailsImageView!{
        didSet{
            imageView.layer.cornerRadius = imageView.frame.height / 3
        }
    }
    
    var cocktail: Drink!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = cocktail.strDrink
        descriptionLabel.text = cocktail.description
        DispatchQueue.global().async {
            
            DispatchQueue.main.async {
                self.imageView.fetchImage(from: self.cocktail.strDrinkThumb)
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
