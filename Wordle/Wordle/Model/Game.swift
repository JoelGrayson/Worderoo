//
//  Game.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Game {
    var size: Int //horizontal length of each word
    var masterWord: String
    var master: Code
    var guess: Code
    var attempts: [Code]
    
    static let numGuessesAllowed = 6
    
    init(startingWord: String, size: Int) {
        self.size = size
        masterWord = startingWord.uppercased()
        master = Code(characters: stringToCharacters(masterWord), kind: .master)
        guess = Code(characters: [], kind: .guess)
        attempts = []
    }
    
    mutating func tryGuessing() -> Result {
        // Guard clauses
        if guess.characters.count < size {
            return .notEnoughChars
        }
        if attempts.contains(where: { prevAttempt in
            prevAttempt.toString() == guess.toString()
        }) {
            return .alreadyTried
        }
        
        // Success
        attempts.append(guess)
        guess.reset()
        
        return .successfullyGuessed
    }
    
    enum Result {
        case notEnoughChars
        case alreadyTried
        case successfullyGuessed
    }
}

