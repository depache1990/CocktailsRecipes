//
//  TableViewCell.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameCocktail: UILabel!
    @IBOutlet weak var imageLabel: CocktailsImageView!{
        didSet{
            imageLabel.contentMode = .scaleAspectFit
            imageLabel.clipsToBounds = true
            imageLabel.layer.cornerRadius = imageLabel.frame.height / 2
            imageLabel.backgroundColor = .white
        }
    }


    
    func configure(with cocktail: Drink?) {
        nameCocktail.text = cocktail?.strDrink
        imageLabel.fetchImage(from: cocktail?.strDrinkThumb ?? "")
        
    }




}
