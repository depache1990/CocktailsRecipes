//
//  WelcomeViewController.swift
//  Bar Academy
//
//  Created by Anton Duplin on 22/8/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private var alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    private var urlString = ""
    private var alphaBetIndex = 0
    private var jsonURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
    
    var drinks: [Drink] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        fetchData(from: urlString)
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cocktailsVK = segue.destination as? UINavigationController else { return }
        let myProfileVC = cocktailsVK.topViewController as? CocktailsTableViewController
        myProfileVC?.drink = drinks
        
    }
    
    private func updateData() {
        for index in alphabet {
            urlString = jsonURL + index
            fetchData(from: urlString)
        }
    }
    
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { cocktails in
            self.drinks += cocktails.drinks
            DispatchQueue.global().async {
                DispatchQueue.main.async {
                    self.title = "Cocktails Shown \(self.drinks.count)"
                    
                    
                }
            }
        }
    }
    
    
    
    
    
    
    
}
