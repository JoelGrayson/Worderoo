//
//  WordleGamePicker.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct WordleGamePicker: View {
    @Environment(\.words) private var words
    @State private var games: [Game] = sampleGames
    @State private var selectedGame: Game?
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            // List of Games
            List(games, selection: $selectedGame) { game in
                NavigationLink(value: game) {
                    GamePreview(game: game)
                }
            }
            .navigationTitle("Wordle")
            
            // New Game Button
            Button {
                let newWord = selectWord()
                if let newWord {
                    games.append(Game(masterWord: newWord))
                } else {
                    //Alert(title: "Could not add game", )
                    print("Could not add game")
                }
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "plus.circle.fill")
                    Text("New Game")
                }
            }
        } detail: {
            if selectedGame != nil {
                // Got help from AI on this one
                WordleView(game:
                    Binding<Game>(
                        get: { self.selectedGame! }, //you can force unwrap because the if statement above
                        set: { self.selectedGame = $0 } //updates the game
                    )
                )
            } else {
                Text("Choose a Game")
            }
        }
        .onChange(of: games) { //Game deleted so remove selection
            if let selectedGame, !games.contains(selectedGame) {
                self.selectedGame = nil
            }
        }
        .navigationSplitViewStyle(.balanced)
    }
    
    func selectWord(ofLength length: Int = Settings.wordSizeForNewGames) -> String? {
        let newWord = words.random(length: length)
        print("Selected", newWord ?? "no word selected")
        return newWord
    }
}

#Preview {
    WordleGamePicker()
}

// Two sample games
var sampleGames = [
    Game(masterWord: "WORLD"),
    Game(masterWord: "TREES")
]

