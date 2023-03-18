//
//  ViewController.swift
//  MusicWireframe
//
//  Created by Дмитрий Имаев on 18.03.2023.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var reverseBackgraund: UIView!
    @IBOutlet weak var playPauseBackgraund: UIView!
    @IBOutlet weak var forwardBackgraund: UIView!
    @IBOutlet weak var reverseButton: UIButton!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    var isPlaying: Bool = true {
        didSet {
            playPauseButton.isSelected = isPlaying
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [reverseBackgraund, playPauseBackgraund, forwardBackgraund].forEach { view in
            view?.layer.cornerRadius = view!.frame.height / 2
            view?.clipsToBounds = true
            view?.alpha = 0.0
        }
    }

    @IBAction func playPauseButtonTapped(_ sender: UIButton) {
        isPlaying.toggle()

        if isPlaying {
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: [], animations: {
                self.albumImageView.transform = CGAffineTransform.identity }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        }
    }
    
    @IBAction func touchedUpInside(_ sender: UIButton) {
        let buttonBackgraund: UIView
        
        switch sender {
        case reverseButton:
            buttonBackgraund = reverseBackgraund
        case playPauseButton:
            buttonBackgraund = playPauseBackgraund
        case forwardButton:
            buttonBackgraund = forwardBackgraund
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackgraund.alpha = 0.0
            sender.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        }) { (_) in
            buttonBackgraund.transform = CGAffineTransform.identity
        }
    }
    
    
    @IBAction func touchedDown(_ sender: UIButton) {
        let buttonBackgraund: UIView
        
        switch sender {
        case reverseButton:
            buttonBackgraund = reverseBackgraund
        case playPauseButton:
            buttonBackgraund = playPauseBackgraund
        case forwardButton:
            buttonBackgraund = forwardBackgraund
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            buttonBackgraund.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
}

