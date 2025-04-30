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
    
    init(masterWord: String, size: Int) {
        self.size = size
        self.masterWord = masterWord.uppercased()
        master = Code(characters: stringToCharacters(masterWord), kind: .master)
        guess = Code(characters: [], kind: .guess)
        attempts = []
    }
    
    mutating func reset() {
        master.reset()
        guess.reset()
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
        attempts.append(guess.guessToAttempt(gradedWith: masterWord))
        guess.reset()
        
        return .successfullyGuessed
    }
    
    
    enum Result {
        case notEnoughChars
        case alreadyTried
        case successfullyGuessed
    }
}

