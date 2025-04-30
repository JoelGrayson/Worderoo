//
//  WordleView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct WordleView: View {
    @State private var game: Game
    
    // TODO: replace these two variables with a computed get/set variable
    let length: Int //useful information to know passed in from above
    let changeLength: (Int) -> Void
    
    @State private var gameIsOver: Bool = false
    @State private var userWon: Bool = false
    
    @State private var message: String?
    
    init(masterWord: String, length: Int, changeLength: @escaping (Int) -> Void) {
        game = Game(masterWord: masterWord, size: 5)
        self.length = length
        self.changeLength = changeLength
    }
    
    var body: some View {
        VStack {
            // Attempts, Guess, and Blank
            ForEach(0..<Game.numGuessesAllowed, id: \.self) { i in //received help from https://www.hackingwithswift.com/forums/swiftui/compiler-warning-non-constant-range-argument-must-be-an-integer-literal/14878
                let code: Code = if i<game.attempts.count { //show the attempts
                    game.attempts[i]
                } else {
                    if i == game.attempts.count { //beneath the attempts show the guess
                        game.guess
                    } else { //below all of that include blank
                        .blank
                    }
                }
                CodeView(for: code, size: game.size)
                // TODO: add shaking if guessing
            }
            
            
            // Keyboard or game over status
            if gameIsOver { // Ending status (won or lost)
                if userWon {
                    Text("Nice job!")
                } else {
                    Text("The word was \(game.masterWord). Better luck next time.")
                }
            } else { // Keyboard
                KeyboardView(onKeyPress: { key in
                    message = nil //hide the message after you type in a new character
                    
                    switch key {
                    case "DELETE":
                        if game.guess.characters.isEmpty {
                            return
                        }
                        game.guess.characters.remove(at: game.guess.characters.index(game.guess.characters.endIndex, offsetBy: -1))
                    case "ENTER":
                        switch game.tryGuessing() {
                        case .successfullyGuessed:
                            break
                        case .alreadyTried:
                            message = "You already guessed that word"
                        case .notEnoughChars:
                            message = "Make sure your guess is \(game.size) letters long"
                        case .notAWord:
                            message = "Please only guess English words"
                        }
                        (gameIsOver, userWon) = game.isOver()
                        print(gameIsOver, userWon)
                    case "RESET":
                        game.reset()
                    default:
                        if game.guess.characters.count < game.size { //this if statement ensures that you don't add a character after all the characters had been typed
                            game.guess.characters.append(.init(value: key))
                        }
                    }
                })
            }
        }
        .padding(.top, 50)
        .overlay(alignment: .top) {
            if let message {
                Text(message)
            }
        }
    }
}

#Preview {
    WordleView(masterWord: Settings.defaultWord, length: 5) { newLength in
        return
    }
}

