//
//  SavedDetailsCocktailViewController.swift
//  Bar Academy
//
//  Created by Anton Duplin on 18/9/22.
//

import UIKit

class SavedDetailsCocktailViewController: UIViewController {

    var cocktailDetail: CocktailModel?
    
    @IBOutlet weak var myCocktailsImage: UIImageView!
    
    @IBOutlet weak var cocktailName: UILabel!
    @IBOutlet weak var ingridientsText: UILabel!
    @IBOutlet weak var instructionText: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cocktailName.text = cocktailDetail?.nameCocktail
        ingridientsText.text = cocktailDetail?.ingridients
        instructionText.text = cocktailDetail?.instruction
        
    }

}
