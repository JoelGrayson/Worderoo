//
//  WordleView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct WordleView: View {
    @State private var game: Game
    
    init(startingMasterWord: String) {
        game = Game(startingWord: startingMasterWord, size: 5)
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
            
            // Keyboard
            KeyboardView(onKeyPress: { key in
                print("Key", key)
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
                        break
                    case .notEnoughChars:
                        break
                    }
                case "RESET":
                    game.reset()
                default:
                    print("Adding", key)
                    game.guess.characters.append(.init(value: key))
                }
            })
        }
//        .onChange(of: words.count) { oldValue, newValue in
//            if game.attempts.count == 0 { //don't interrupt an old game
//
//            }
//        }
    }
}

#Preview {
    WordleView(startingMasterWord: "WORLD")
}

