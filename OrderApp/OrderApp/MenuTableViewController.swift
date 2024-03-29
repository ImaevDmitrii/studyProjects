//
//  MenuTableViewController.swift
//  OrderApp
//
//  Created by Дмитрий Имаев on 27.04.2023.
//

import UIKit

@MainActor
class MenuTableViewController: UITableViewController {
    
    let category: String
    var menuItems = [MenuItem]()
    
   init?(coder: NSCoder, category: String){
        self.category = category
        super.init(coder: coder)
    }   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBSegueAction func showMenuItem(_ coder: NSCoder, sender: Any?) -> MenuItemDetailViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) else {return nil}
        
        let menuItem = menuItems[indexPath.row]
        
        return MenuItemDetailViewController(coder: coder, menuItem: menuItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.capitalized
        
        Task.init {
            do {
                let menuItems = try await MenuController.shared.fetchMenutems(forCategory: category)
                updateUI(with: menuItems)
            } catch {
                displayError(error, title: "Fieled to Fetch Menu Items for \(self.category)")
            }
        }
        
        
        func updateUI(with menuItems: [MenuItem]) {
            self.menuItems = menuItems
            self.tableView.reloadData()
        }
        
        func displayError(_ error: Error, title: String) {
            guard let _ = viewIfLoaded?.window else { return }
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }
    
   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItem", for: indexPath)
        
        configure(cell, forItemAt: indexPath)
        
        return cell
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = menuItem.name
        content.secondaryText = menuItem.price.formatted(.currency(code: "usd"))
        
        cell.contentConfiguration = content
    }
    
}
