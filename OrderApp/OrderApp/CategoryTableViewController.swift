//
//  CategoryTableViewController.swift
//  OrderApp
//
//  Created by Дмитрий Имаев on 27.04.2023.
//

import UIKit

@MainActor
class CategoryTableViewController: UITableViewController {
    
    
    var categories = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task.init{
            do {
                let categries = try await MenuController.shared.fetchCategories()
                updateUI(with: categries)
            } catch {
                displayError(error, title: "Field to Fetch Categories")
            }
        }
    }
    
    func updateUI(with categories: [String]) {
        self.categories = categories
        self.tableView.reloadData()
    }
    
    func displayError(_ error: Error, title: String){
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    @IBSegueAction func showMenu(_ coder: NSCoder, sender: Any?) -> MenuTableViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return nil}
        
        let category = categories[indexPath.row]
        
        return MenuTableViewController(coder: coder, category: category)
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Category", for: indexPath)
        configureCell(cell, forCategoryAt: indexPath)
        
        return cell
    }
 
    func configureCell(_ cell: UITableViewCell, forCategoryAt indexPath: IndexPath){
        let category = categories[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = category.capitalized
        cell.contentConfiguration = content
    }
    
}
