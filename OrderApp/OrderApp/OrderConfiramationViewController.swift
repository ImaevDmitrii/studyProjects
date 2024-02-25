//
//  OrderConfiramationViewController.swift
//  OrderApp
//
//  Created by Дмитрий Имаев on 16.06.2023.
//

import UIKit

class OrderConfiramationViewController: UIViewController {
    
    @IBOutlet var confirmationLabel: UILabel!
    
    let minutesToPrepare: Int
    
    init?(coder: NSCoder, minutesToPrepare: Int) {
        self.minutesToPrepare = minutesToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmationLabel.text = "Thanks you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue){
        if segue.identifier == "dismissConfirmation" {
            MenuController.shared.order.menuItems.removeAll()
        }
        
    }
    
}
