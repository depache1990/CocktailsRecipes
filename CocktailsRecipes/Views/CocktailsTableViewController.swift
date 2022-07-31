//
//  CocktailsTableViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    private var cocktails: Cocktails?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(from: URLS.cocktailsRecipes.rawValue )
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails?.drinks.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

      let cocktailBar = cocktails?.drinks[indexPath.row]
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
    
    private func fetchData(from url: String) {
        NetworkManager.shared.fetchData(from: url) { cocktails in
            self.cocktails = cocktails
            self.tableView.reloadData()
        }
        
    }
}
