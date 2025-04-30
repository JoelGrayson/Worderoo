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
        // Guard clauses for why you couldn't add the guess to attempts
        if guess.characters.count < size {
            return .notEnoughChars
        }
        if attempts.contains(where: { prevAttempt in
            prevAttempt.toString() == guess.toString()
        }) {
            return .alreadyTried
        }
        
        // Successfully add the guess
        attempts.append(guess.guessToAttempt(gradedWith: masterWord))
        guess.reset()
        
        return .successfullyGuessed
    }
    
    func isOver() -> (gameIsOver: Bool, userWon: Bool) { // CM 4 for using tuple
        let userWon = attempts.last?.characters.allSatisfy { $0.status == .correct } ?? false
        let outOfGuesses = attempts.count == Game.numGuessesAllowed
        
        return (
            gameIsOver: userWon || outOfGuesses,
            userWon: userWon
        )
    }
    
    
    enum Result {
        case successfullyGuessed
        
        // Could not make a guess because the guess was problematic
        case notEnoughChars
        case alreadyTried
    }
}

