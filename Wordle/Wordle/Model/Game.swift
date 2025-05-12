//
//  Game.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

@Observable
class Game: Identifiable, Hashable {
    var size: Int //horizontal length of each word
    var masterWord: String
    var master: Code
    var guess: Code
    var attempts: [Code]
    
    var gameIsOver = false
    var userWon = false
    
    var lastGuessMadeAt: Date = .now
    
    var startTime: Date? = nil
    var endTime: Date? = nil
    var pausedAt: Date? = nil
    
    init(masterWord: String) {
        self.size = masterWord.count
        self.masterWord = masterWord.uppercased()
        master = Code(characters: stringToCharacters(masterWord), kind: .master)
        guess = Code(characters: [], kind: .guess)
        attempts = []
    }
    
    // Second initializer used for the sample games, which are at various completion levels
    convenience init(masterWord: String, attempts: [Code]) {
        self.init(masterWord: masterWord)
        self.attempts = attempts
    }
    
    // From AI for Identifiable and Hashable conformance
    var id = UUID()
    
    static func ==(lhs: Game, rhs: Game) -> Bool {
        return lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }


//    mutating func reset(newMasterWord: String? = nil) { //if no new word is provided, it is the same word
//        size = Int(newGameWordSize)
//        gameIsOver = false
//        userWon = false
//        selectWord(Int(newGameWordSize))
//        
//        master.reset()
//        guess.reset()
//        attempts = []
//        if let newMasterWord {
//            masterWord = newMasterWord
//        }
//    }
    
    func tryGuessing() -> Result {
        // Guard clauses for why you couldn't add the guess to attempts
        guard guess.characters.count == size else {
            return .notEnoughChars
        }
        if attempts.contains(where: { prevAttempt in
            prevAttempt.toString() == guess.toString()
        }) {
            return .alreadyTried
        }
        if HardCodedSettings.checkIfEnglishWord {
            guard isEnglishWord(guess.toString().lowercased()) else { //asserts that it is word
                return .notAWord
            }
            
            // Old system which only works on the tiny word list
//            guard words.contains(guess.toString()) else {
//                return .notAWord
//            }
        }

        
        // Successfully add the guess
        attempts.append(guess.guessToAttempt(gradedWith: masterWord))
        lastGuessMadeAt = .now
        guess.reset()
        
        return .successfullyGuessed
    }
    
    func isOver(numGuessesAllowed: Int) -> (gameIsOver: Bool, userWon: Bool) { // CM4 for using tuple
        let userWon = attempts.last?.characters.allSatisfy { $0.status == .correct } ?? false
        let outOfGuesses = attempts.count == numGuessesAllowed
        
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
        case notAWord
    }
}

