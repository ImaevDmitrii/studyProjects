//
//  ViewController.swift
//  Apple Pie
//
//  Created by Дмитрий Имаев on 13.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var treeImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var latterButtons: [UIButton]!
    
    var listOfWolds = ["spain","mexico","argentina","colombia","chile","cuba","peru"]
    
    let incorrectMovesAllowed = 7
    
    var totalWins = 0 {
        didSet{
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.configuration!.title!
        let letter = Character(letterString.lowercased())
        currentGame.platerGussed(letter: letter)
        updateGameStats()
    }
    
    var currentGame: Game!
    
    func newRound () {
        if !listOfWolds.isEmpty {
            let newWorld = listOfWolds.removeFirst()
            
            currentGame = Game(word: newWorld, inccorectMovesRemaining: incorrectMovesAllowed, guessLetters: [])
            enableLettersButtons(true)
            updateUI()
        } else {
            enableLettersButtons(false)
        }
    }
        
        func updateUI() {
            var letters = [String]()
            for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
            let wordWithSpacing = letters.joined(separator: " ")
            
            correctWordLabel.text = wordWithSpacing
            scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
            treeImageView.image = UIImage(named: "Tree \(currentGame.inccorectMovesRemaining)")
        }
        
        func updateGameStats(){
            if currentGame.inccorectMovesRemaining == 0 {
                totalLosses += 1
            } else if currentGame.word == currentGame.formattedWord{
                totalWins += 1
            } else {
                updateUI()
            }
            
        }

func enableLettersButtons (_ enable: Bool){
    for button in latterButtons {
        button.isEnabled = enable
    }
}
}
