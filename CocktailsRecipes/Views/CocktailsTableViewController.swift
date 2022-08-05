//
//  CocktailsTableViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    var cocktails: Cocktails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails?.drinks.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let cocktailBar = cocktails?.drinks[indexPath.row]
        if indexPath.row == (cocktails?.drinks.count ?? 0)-1 && alphaBetIndex < alphabet.count {
            NetworkManager.shared.fetchData { cocktails in
                self.cocktails = cocktails
                //self.tableView.reloadData()
                DispatchQueue.main.async {
                    self.title = "Cocktails Shown \(self.cocktails?.drinks.count ?? 0)"
                    self.tableView.reloadData()
                }
            }
        }
        cell.configure(with: cocktailBar)
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let cocktailsList = cocktails?.drinks[indexPath.row]
        let details = segue.destination as! CocktailsDetailsViewController
        details.cocktail = cocktailsList
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchData { cocktails in
            self.cocktails = cocktails
            self.tableView.reloadData()
            DispatchQueue.main.async {
                self.title = "Cocktails Shown \(self.cocktails?.drinks.count ?? 0)"
                self.tableView.reloadData()
                
            }
        }
    }
}
