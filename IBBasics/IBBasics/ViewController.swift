//
//  ViewController.swift
//  IBBasics
//
//  Created by Дмитрий Имаев on 08.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myButton: UIButton!
    @IBOutlet var label: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        myButton.tintColor = .red
    }

    
    @IBAction func buttonPressed(_ sender: Any) {
        label.text = "Es una locura!"
    }
    
}

