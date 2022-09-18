//
//  SavedTableViewController.swift
//  Bar Academy
//
//  Created by Anton Duplin on 10/9/22.
//

import UIKit
protocol CreateCocktailViewControllerDelegate {
    func saveCocktail(_ cocktail: MakeCocktails)
    }

class SavedTableViewController: UITableViewController {
    
    private var cocktails: [MakeCocktails] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktails = StorageManager.shared.fetchCocktails()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newContactVC = segue.destination as! CreateCocktailViewController
        newContactVC.delegate = self
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! SavedDetailsCocktailViewController 
            detailVC.cocktailDetail = cocktails[indexPath.row]
        }
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cocktails", for: indexPath)
        let cocktail = cocktails[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = cocktail.nameCocktail
        cell.contentConfiguration = content
        
        return cell
    }

}
extension SavedTableViewController: CreateCocktailViewControllerDelegate {
    func saveCocktail(_ cocktail: MakeCocktails) {
        cocktails.append(cocktail)
        tableView.reloadData()
    }
}
