//
//  TableViewCell.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var favorite = false
    @IBOutlet weak var nameCocktail: UILabel!
    @IBOutlet weak var imageLabel: CocktailsImageView!{
        didSet{
            imageLabel.contentMode = .scaleAspectFit
            imageLabel.clipsToBounds = true
            imageLabel.layer.cornerRadius = imageLabel.frame.height / 2
            imageLabel.backgroundColor = .white
        }
    }


    
    func configure(with cocktail: Drink?, cellIndex: Int) {
        nameCocktail.text = cocktail?.strDrink
        imageLabel.fetchImage(from: cocktail?.strDrinkThumb ?? "")

        let favoriteButton = UIButton(type: .custom)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        favoriteButton.tintColor = favorite ? .systemRed : .gray
        favoriteButton.tag = cellIndex
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        
        accessoryView = favoriteButton
        
        
    }
    
    @objc private func favoriteButtonPressed(_ sender: UIButton) {
        favorite.toggle()

        sender.tintColor = favorite ? .systemRed : .lightGray
    }




}
