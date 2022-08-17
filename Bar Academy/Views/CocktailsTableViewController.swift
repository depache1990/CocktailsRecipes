//
//  CocktailsTableViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    var drink: [Drink] = []
    
    private var alphabet = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
    private var urlString = ""
    private var alphaBetIndex = 0
    private var jsonURL = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f="
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredCocktails = [Drink]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!searchBarIsEmpty || searchBarScopeIsFiltering)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateData()
        fetchData(from: urlString)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for Cocktail"
        searchController.searchBar.scopeButtonTitles = ["All","Non Alcoholic"]
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
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
        let details = segue.destination as! CocktailsDetailsViewController
        details.cocktail = drinks
    }
    private func updateData() {
        for index in alphabet {
            urlString = jsonURL + index
            fetchData(from: urlString)
        }
        
    }
    
    private func fetchData(from url: String?) {
        NetworkManager.shared.fetchData(from: url) { cocktails in
            self.drink += cocktails.drinks
            //self.tableView.reloadData()
            DispatchQueue.main.async {
                self.title = "Cocktails Shown \(self.drink.count)"
                self.tableView.reloadData()
                
            }
        }
    }
}

extension CocktailsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    private func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredCocktails = drink.filter({ (drink: Drink) -> Bool in
            
            let doesCategoryMatch = (scope == "All") || (drink.strDrink == scope) || (drink.strAlcoholic != "Alcoholic")
            
            if searchBarIsEmpty {
                return doesCategoryMatch
            } else {
                return doesCategoryMatch && drink.strDrink.lowercased().contains(searchText.lowercased())
            }
        })
        
        tableView.reloadData()
    }
}

extension CocktailsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchbar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchbar.text!, scope: searchbar.scopeButtonTitles![selectedScope])
    }
    
}
