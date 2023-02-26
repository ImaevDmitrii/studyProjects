//
//  Game.swift
//  Apple Pie
//
//  Created by Дмитрий Имаев on 13.12.2022.
//

import Foundation


struct Game {
    var word :String
    var inccorectMovesRemaining: Int
    var guessLetters: [Character]
    
    var formattedWord: String  {
        var gussedWord = ""
        
        for letter in word {
            if guessLetters.contains(letter) {
                gussedWord += "\(letter)"
            } else {
                gussedWord += "_"
            }
        }
            return gussedWord
    }
    
    mutating func platerGussed (letter: Character){
        guessLetters.append(letter)
        if !word.contains(letter) {
            inccorectMovesRemaining -= 1
        }
    }
    
    
}
