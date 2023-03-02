//
//  FoodTableViewController.swift
//  Meal Tracker
//
//  Created by Дмитрий Имаев on 02.03.2023.
//

import UIKit

class FoodTableViewController: UITableViewController {
    
    
    var meals: [Meal] {
        return [
            Meal(name: "Breakfast", food: [
                Food(name: "Bread", description: "Toast"),
                Food(name: "Chise", description: "Mozarella"),
                Food(name: "Coffee", description: "Turkish")
            ]
                ),
            Meal(name: "Lunch", food: [
                Food(name: "Soup", description: "Gaspacho"),
                Food(name: "Bread", description: "Normal"),
                Food(name: "Milk", description: "Normal")
            ]
                ),
            Meal(name: "Dinner", food: [
                Food(name: "Pasta", description: "Carbonara"),
                Food(name: "Tea", description: "Black tea"),
                Food(name: "Apple", description: "Green Apple")
            ]
                )
        ]
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
            return meals[section].food.count
        }
    
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
            let food = meals[indexPath.section].food[indexPath.row]
            
            cell.textLabel?.text = food.name
            cell.detailTextLabel?.text = food.description
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return meals[section].name
        }
    }
