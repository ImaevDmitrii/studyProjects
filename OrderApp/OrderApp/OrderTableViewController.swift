//
//  OrderTableViewController.swift
//  OrderApp
//
//  Created by Дмитрий Имаев on 27.04.2023.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var minutesToPrepareOrder = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdateNotification, object: nil)
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MenuController.shared.order.menuItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Order", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at: indexPath.row)
        }
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath: IndexPath) {
        let menuItem = MenuController.shared.order.menuItems[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = menuItem.name
        content.secondaryText = menuItem.price.formatted(.currency(code: "usd"))
        cell.contentConfiguration = content
    }
    @IBSegueAction func confirmOrder(_ coder: NSCoder) -> OrderConfiramationViewController? {
        return OrderConfiramationViewController(coder: coder, minutesToPrepare: minutesToPrepareOrder)
    }
    
    @IBAction func sumbitTapped(_ sender: Any) {
        let orderTotal = MenuController.shared.order.menuItems.reduce(0.0){ (result, menuItem) -> Double in return result + menuItem.price
        }
        let formattedTotal = orderTotal.formatted(.currency(code: "usd"))
        
        let alertController = UIAlertController(title: "Confirm Order", message: "You are about to sumbit your order with a total of \(formattedTotal)", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sumbit", style: .default, handler: {_ in self.uploadOrder() }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
    
    func uploadOrder(){
        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
        Task.init {
            do {
                let minutesToPrepare = try await MenuController.shared.sumbitOrder(forMenuIDs: menuIds)
                minutesToPrepareOrder = minutesToPrepare
                performSegue(withIdentifier: "confirmOrder", sender: nil)
            } catch {
                displayError(error, title: "Order Sumbission Failed")
            }
        }
    }
    
    func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else {return}
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
