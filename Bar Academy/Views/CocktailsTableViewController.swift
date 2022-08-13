//
//  CocktailsTableViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    var drink: [Drink] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCocktails = [Drink]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Cocktail"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
                return filteredCocktails.count
            }
            return drink.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        if indexPath.row == (drink.count)-1 && NetworkManager.shared.alphaBetIndex < alphabet.count {
            NetworkManager.shared.fetchData { cocktails in
                self.drink += cocktails.drinks
                DispatchQueue.main.async {
                    self.title = "Cocktails Shown \(self.drink.count)"
                    self.tableView.reloadData()
                }
            }
        }
        var drinks: Drink
        if isFiltering {
            drinks = filteredCocktails[indexPath.row]
        } else {
            drinks = drink[indexPath.row]
        }
        //let cocktailBar = drink[indexPath.row]
        cell.configure(with: drinks)
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        var drinks: Drink
        if isFiltering {
            drinks = filteredCocktails[indexPath.row]
        } else {
            drinks = drink[indexPath.row]
        }
        //let cocktailsList = drink[indexPath.row]
        let details = segue.destination as! CocktailsDetailsViewController
        details.cocktail = drinks
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

extension CocktailsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        
        filteredCocktails = drink.filter({ (drink: Drink) -> Bool in
            return drink.strDrink.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    
}
