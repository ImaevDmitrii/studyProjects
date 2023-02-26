//
//  ViewController.swift
//  LogIn
//
//  Created by Дмитрий Имаев on 21.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var fargotUsernameButton: UIButton!
    
    @IBOutlet weak var fargotPasswordButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sender = sender as? UIButton else {return}
        if sender == fargotPasswordButton {
            segue.destination.navigationItem.title = "Fargot Password"
        } else if sender == fargotUsernameButton {
            segue.destination.navigationItem.title = "Fargot Username"
        } else {
            segue.destination.navigationItem.title = usernameText.text
        }
    }
    
    @IBAction func fargotUsernameTapped(_ sender: Any) {
        performSegue(withIdentifier: "FargorSegue", sender: sender)
    }
    
    @IBAction func fargotPasswordTapped(_ sender: Any) {
        performSegue(withIdentifier: "FargorSegue", sender: sender)
    }
    
}
        
        
        
        
        

