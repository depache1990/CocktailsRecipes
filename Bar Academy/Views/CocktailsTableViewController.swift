//
//  CocktailsTableViewController.swift
//  CocktailsRecipes
//
//  Created by Anton Duplin on 29/7/22.
//

import UIKit

class CocktailsTableViewController: UITableViewController {
    
    var drink: [Drink] = []
    var makeCocktail: [CocktailModel] = []
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateTableView()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cocktails Shown \(self.drink.count)"
        
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
        isFiltering ? filteredCocktails.count : drink.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let drinks = isFiltering ? filteredCocktails[indexPath.row] : drink[indexPath.row]
        //let makeDrinks = makeCocktail[indexPath.row]
        cell.configure(with: drinks, cellIndex: indexPath.row)
        cell.tintColor = .lightGray
        
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
    private func animateTableView () {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableViewheight = tableView.bounds.height
        var delay: Double = 0
        
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableViewheight)
            
            UIView.animate(
                withDuration: 1.5,
                delay: delay * 0.03,
                usingSpringWithDamping: 0.8,
                initialSpringVelocity: 0,
                options: .curveEaseOut,
                animations: {
                    cell.transform = CGAffineTransform.identity
                })
            delay += 1
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
