//
//  MiddleViewController.swift
//  OrderOfEvents
//
//  Created by Дмитрий Имаев on 21.12.2022.
//

import UIKit

class MiddleViewController: UIViewController {
    
    
    @IBOutlet weak var middleLabel: UILabel!
    
    
    var eventNumber = 1
    
    func addEvent(from: String) {
        if let existingText = middleLabel.text {
            middleLabel.text = "\(existingText)\n Event number \(eventNumber) was \(from)"
            eventNumber += 1
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addEvent(from: "viewDidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addEvent(from: "viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addEvent(from: "viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        addEvent(from: "viewWillDisappear")
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        addEvent(from: "viewDidDisappear")
    }
    
}


