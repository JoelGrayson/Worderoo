//
//  WordleView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct WordleView: View {
    @Environment(\.words) var words
    @State private var game = Game(startingWord: "WORLD", size: 5)
    
    var body: some View {
        VStack {
            // Guess
            CodeView(for: game.guess, size: game.size)
                // TODO: animation for shaking when wrong
            
            // Attempts
            ForEach(0..<Game.numGuessesAllowed, id: \.self) { i in //received help from https://www.hackingwithswift.com/forums/swiftui/compiler-warning-non-constant-range-argument-must-be-an-integer-literal/14878
                CodeView(for: i<game.attempts.count ? game.attempts[i] : .blank, size: game.size)
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
    WordleView()
}
