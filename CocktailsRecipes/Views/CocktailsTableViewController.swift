//
//  CocktailsTableViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    var drink: [Drink] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drink.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if indexPath.row == (drink.count)-1 && alphaBetIndex < alphabet.count {
            NetworkManager.shared.fetchData { cocktails in
                self.drink += cocktails.drinks
                DispatchQueue.main.async {
                    self.title = "Cocktails Shown \(self.drink.count)"
                    self.tableView.reloadData()
                }
            }
        }
        let cocktailBar = drink[indexPath.row]
        cell.configure(with: cocktailBar)
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let cocktailsList = drink[indexPath.row]
        let details = segue.destination as! CocktailsDetailsViewController
        details.cocktail = cocktailsList
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData { cocktails in
            self.drink += cocktails.drinks
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.title = "Cocktails Shown \(self.drink.count)"
                self.tableView.reloadData()
                
            }
        }
    }
}
