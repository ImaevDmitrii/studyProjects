//
//  ViewController.swift
//  light
//
//  Created by Дмитрий Имаев on 08.12.2022.
//

import UIKit

class ViewController: UIViewController {

    
    var lightOn = true
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view.
    }

    fileprivate func updateUI() {
        view.backgroundColor = lightOn ? .white : .black
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        lightOn.toggle()
        updateUI()
    }
    
}

