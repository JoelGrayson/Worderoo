//
//  GameView.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI
import SwiftData

struct GameView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var configurableSettings: ConfigurableSettings
    
    // Get game
    let game: Game //immutable game. Includes all the information about the game including masterWord, attempts, ...
    // Passed in actions that let you set the game
    var onDisappear: () -> Void
    var onAppear: () -> Void
    var endGame: () -> Void
    // Keyboard operations
    var typeCharacter: (_ character: String) -> Void
    var deleteCharacter: () -> Void

    
    // State specific to the current game playing view
    @State private var message: String?

    var body: some View {
        VStack {
            if HardCodedSettings.showAnswer {
                Text("Answer: \(game.masterWord)")
            }
            
            if let message {
                Text(message)
            }
            
            // Attempts, Guess, and Blank
            ForEach(0..<configurableSettings.numGuessesAllowed, id: \.self) { i in //received help from https://www.hackingwithswift.com/forums/swiftui/compiler-warning-non-constant-range-argument-must-be-an-integer-literal/14878
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
            }
            
            
            // Keyboard or game over status
            if game.isOver { // Ending status (won or lost)
                if game.userWon {
                    Text("Nice job!")
                } else {
                    Text("The word was \(game.masterWord). Better luck next time.")
                }
            } else { // Keyboard
                KeyboardWrapper(
                    message: $message,
                    configurableSettings: configurableSettings,
                    game: game,
                    endGame: endGame,
                    typeCharacter: { key in
                        game.guess.characters.append(.init(value: key))
                    },
                    deleteCharacter: {
                        game.guess.characters.remove(
                            at: game.guess.characters.index(
                                game.guess.characters.endIndex,
                                offsetBy: -1
                            )
                        )
                    }
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ElapsedTime(startTime: game.startTime, endTime: game.endTime)
                .monospaced()
                .lineLimit(1)
        }
        .onAppear {
            onAppear()
        }
        .onDisappear {
            onDisappear()
        }
        .onChange(of: scenePhase) {
            switch scenePhase {
            case .background:
                onDisappear()
            case .active:
                onAppear()
            default:
                break
            }
        }
    }
}

//#Preview {
//    @Previewable @State var games = sampleGames //https://www.avanderlee.com/swiftui/previewable-macro-usage-in-previews/
//    GameView(game: games[0], onDisappear: {}, onAppear: {}, configurableSettings: ConfigurableSettings())
//}

