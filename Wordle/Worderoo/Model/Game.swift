//
//  Game.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI
import SwiftData

@Model
class Game: Equatable {
    var size: Int //horizontal length of each word
    var masterWord: String
    var master: Code
    var guess: Code
    var attempts: [Code]
    
    var isOver = false
    var userWon = false
    
    var lastGuessedAt = Date.now
    
    var startTime = Date.now
    var endTime: Date? = nil
    var pausedAt: Date? = nil
    
    init(masterWord: String) {
        self.size = masterWord.count
        self.masterWord = masterWord.uppercased()
        master = Code(characters: stringToCharacters(masterWord), kind: .master)
        guess = Code(characters: [], kind: .guess)
        attempts = []
        startTime = .now
        lastGuessedAt = .now //used for sorting
    }
    
    // Second initializer used for the sample games, which are at various completion levels
    convenience init(masterWord: String, attempts: [Code], isOver: Bool = false) {
        self.init(masterWord: masterWord)
        self.attempts = attempts
        self.isOver = isOver
        
        (self.isOver, self.userWon) = self.selfIsOver(numGuessesAllowed: Constants.highNumberToIgnore)
        if isOver {
            self.startTime = .now
            self.endTime = .now
        }
    }
    

    func tryGuessing(checkIfEnglishWord: Bool) -> Result {
        // Guard clauses for why you couldn't add the guess to attempts
        guard guess.characters.count == size else {
            return .notEnoughChars
        }
        if attempts.contains(where: { prevAttempt in
            codeToString(prevAttempt) == codeToString(guess)
        }) {
            return .alreadyTried
        }
        if checkIfEnglishWord {
            guard isEnglishWord(codeToString(guess).lowercased()) else { //asserts that it is word
                return .notAWord
            }
            
            // Old system which only works on the tiny word list
//            guard words.contains(guess.toString()) else {
//                return .notAWord
//            }
        }

        
        // Successfully add the guess
        attempts.append(guess.guessToAttempt(gradedWith: masterWord))
        lastGuessedAt = .now
        guess.reset()
        
        return .successfullyGuessed
    }
    
    func selfIsOver(numGuessesAllowed: Int) -> (isOver: Bool, userWon: Bool) { // CM4 for using tuple
        let userWon = attempts.last?.characters.allSatisfy { $0.status == .correct } ?? false
        let outOfGuesses = attempts.count >= numGuessesAllowed
        
        return (
            isOver: userWon || outOfGuesses,
            userWon: userWon
        )
    }
}

enum Result {
    case successfullyGuessed
    
    // Could not make a guess because the guess was problematic
    case notEnoughChars
    case alreadyTried
    case notAWord
}

