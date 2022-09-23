//
//  SavedTableViewController.swift
//  Bar Academy
//
//  Created by Anton Duplin on 10/9/22.
//

import UIKit

protocol CreateCocktailViewControllerDelegate {
    
    func saveCocktail(with newCocktail: CocktailModel?, ingridients: String, instruction: String, nameCocktail: String)
}

class SavedTableViewController: UITableViewController {
    
    private var cocktails: [CocktailModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cocktails = StorageManager.shared.fetchCocktails()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            if let indexPath = tableView.indexPathForSelectedRow {
                guard let detailVC = segue.destination as? SavedDetailsCocktailViewController else { return }
                detailVC.cocktailDetail = cocktails[indexPath.row]
            }
        } else {
            guard let createVC = segue.destination as? CreateCocktailViewController else { return }
            createVC.delegate = self
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            StorageManager.shared.deleteContact(at: indexPath.row)
            cocktails.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    @IBAction func logInAction() {
        performSegue(withIdentifier: "showCocktail", sender: nil)
        
    }
}

extension  SavedTableViewController {
    private func saveNewCocktail(newCocktail: CocktailModel) {
        StorageManager.shared.save(cocktail: newCocktail)
        cocktails.append(newCocktail)
    }
 
}
extension SavedTableViewController: CreateCocktailViewControllerDelegate {
    func saveCocktail(with newCocktail: CocktailModel?, ingridients: String, instruction: String, nameCocktail: String) {
        guard let newCocktail = newCocktail else { return }
        saveNewCocktail(newCocktail: newCocktail)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
