//
//  WordleView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct WordleView: View {
    @Binding var game: Game //includes all the information about the game including masterWord, attempts, ...
    var configurableSettings: ConfigurableSettings
    
    // State specific to the current game playing view
    @State private var message: String?
    
    var body: some View {
        VStack {
            if HardCodedSettings.showAnswer {
                Text("Answer: \(game.masterWord)")
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
            if game.gameIsOver { // Ending status (won or lost)
                if game.userWon {
                    Text("Nice job!")
                } else {
                    Text("The word was \(game.masterWord). Better luck next time.")
                }
            } else { // Keyboard
                KeyboardView(
                    onKeyPress: { key in
                        message = nil //hide the message after you type in a new character
                        
                        switch key {
                        case "DELETE":
                            if game.guess.characters.isEmpty {
                                return
                            }
                            game.guess.characters.remove(at: game.guess.characters.index(game.guess.characters.endIndex, offsetBy: -1))
                        case "ENTER":
                            switch game.tryGuessing(checkIfEnglishWord: configurableSettings.checkIfEnglishWord) {
                            case .successfullyGuessed:
                                break
                            case .alreadyTried:
                                message = "You already guessed that word"
                            case .notEnoughChars:
                                message = "Make sure your guess is \(game.size) letters long"
                            case .notAWord:
                                message = "Please only guess English words"
                            }
                            (game.gameIsOver, game.userWon) = game.isOver(numGuessesAllowed: configurableSettings.numGuessesAllowed)
                        default:
                            if game.guess.characters.count < game.size { //this if statement ensures that you don't add a character after all the characters had been typed
                                game.guess.characters.append(.init(value: key))
                            }
                        }
                    },
                    getKeyStatus: { key in
                        if key == "ENTER" || key == "DELETE" || key == "RESET" {
                            return .blank //these should not be colored
                        }
                        
                        var wasInWrongSpot = false //if it was in the wrong spot at any point, wrong spot will be returned unless it was correct somewhere else (that takes precedence)
                        var wasGuessedButNotInWord = false //this has the least precedence
                        
                        for attempt in game.attempts {
                            for (i, character) in attempt.characters.enumerated() { //foreach guessed character
                                if character.value == key {
                                    // Correct takes precedence as in if the key was correct once, it is correct always
                                    let masterWordI = game.masterWord.index(game.masterWord.startIndex, offsetBy: i)
                                    if String(game.masterWord[masterWordI]) == character.value {
                                        return .correct
                                    }
                                    
                                    if game.masterWord.contains(character.value) {
                                        wasInWrongSpot = true
                                    } else {
                                        wasGuessedButNotInWord = true
                                    }
                                }
                            }
                        }
                        
                        if wasInWrongSpot {
                            return .wrongPlace
                        }
                        if wasGuessedButNotInWord {
                            return .notIn
                        }
                        
                        return .blank
                    }
                )
            }
        }
        .toolbar {
            if let startTime = game.startTime {
                ElapsedTime(startTime: startTime, endTime: game.endTime)
                    .monospaced()
                    .lineLimit(1)
            }
        }
        .onAppear {
            onAppear(game: game)
        }
        .onDisappear {
            onDisappear(game: game)
        }
        .onChange(of: game) { oldGame, newGame in
            // old onDisappear
            onDisappear(game: oldGame)
            
            // old onAppear
            onAppear(game: newGame)
        }
        .padding(.top, 50)
        .overlay(alignment: .top) {
            if let message {
                Text(message)
            }
        }
        .onChange(of: game.masterWord) { oldValue, newValue in //ensure that the master word of the game and the characters are in sync
            game.master.characters = stringToCharacters(game.masterWord)
        }
    }
    
    func onDisappear(game: Game) {
        game.pausedAt = .now
    }
    
    func onAppear(game: Game) {
        // When first opening the game, set the start time
        if game.startTime == nil {
            game.startTime = .now
        }
        
        // If there was a pause duration, do the offset
        if let pausedAt = game.pausedAt {
            let pausedForDuration = Date().timeIntervalSince1970 - pausedAt.timeIntervalSince1970
            if let startTime = game.startTime {
                game.startTime = startTime.advanced(by: pausedForDuration)
            }
            game.pausedAt = nil
        }
    }
}

#Preview {
    @Previewable @State var games = sampleGames //https://www.avanderlee.com/swiftui/previewable-macro-usage-in-previews/
    WordleView(game: $games[0], configurableSettings: ConfigurableSettings())
}

