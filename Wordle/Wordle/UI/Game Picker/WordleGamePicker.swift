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
    @State private var configurableSettings = ConfigurableSettings()
    
    var sortedGames: [Game] {
        games.sorted(by: { $0.lastGuessMadeAt > $1.lastGuessMadeAt })
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            // Title which is used in place of navigationTitle and toolbar because the latter acts strangely alignment-wise
            HStack(alignment: .center) {
                Text("Wordle")
                    .font(.title)
                    .bold()
                    .padding()
                Spacer()
                SettingsView(configurableSettings: $configurableSettings)
                    .padding()
            }
            .padding()
            
            
            // Empty list of games if appropriate
            if games.isEmpty {
                Text("No games yet.")
                    .padding(.top, 100)
            }
            
            // List of Games
            List(sortedGames, selection: $selectedGame) { game in //received help from AI on making the bindings work
                NavigationLink(value: game) {
                    GamePreview(game: game, configurableSettings: configurableSettings)
                        .contextMenu {
                            Button("Delete") {
                                deleteGame(game)
                            }
                        }
                        // Read the docs at https://developer.apple.com/documentation/swiftui/view/swipeactions(edge:allowsfullswipe:content:)
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                deleteGame(game)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .ipadListLooksGood()
            // Not using below because it has weird alignment
//            .navigationTitle("Wordle")
//            .toolbar {
//                SettingsView()
//            }
            
            
            // New Game Button
            Button {
                let newWord = selectWord()
                if let newWord {
                    withAnimation {
                        games.append(Game(masterWord: newWord))
                    }
                } else {
                    //Alert(title: "Could not add game", )
                    print("Could not add game")
                }
            } label: {
                HStack(alignment: .center, spacing: 10) {
                    Image(systemName: "plus.circle.fill")
                    Text("New Game")
                }
                .padding(.vertical)
            }
            .padding(.top)
        } detail: {
            if let selectedGame = selectedGame {
                // Got help from AI on this one
                WordleView(game:
                    Binding<Game>(
                        get: { selectedGame },
                        set: { self.selectedGame = $0 } //updates the game
                    ),
                   configurableSettings: configurableSettings
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
    
    func selectWord(ofLength length: Int = -1) -> String? {
        let lengthToUse = length == -1 ? configurableSettings.wordSizeForNewGames : length
        let newWord: String? = words.random(length: lengthToUse)
        print("Selected", newWord ?? "no word selected")
        return newWord
    }
    
    func deleteGame(_ game: Game) {
        let indexToRemove = games.firstIndex(where: { el in
            el == game
        })
        
        if let indexToRemove {
            games.remove(at: indexToRemove)
        }
    }
}

#Preview {
    WordleGamePicker()
}

// Two sample games
var sampleGames = [
    Game(masterWord: "TREES", attempts: [ //in the middle
        Code(
            characters: [
                Character(value: "R", status: .wrongPlace),
                Character(value: "O", status: .notIn),
                Character(value: "U", status: .notIn),
                Character(value: "G", status: .notIn),
                Character(value: "H", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "T", status: .correct),
                Character(value: "A", status: .notIn),
                Character(value: "N", status: .notIn),
                Character(value: "G", status: .notIn),
                Character(value: "O", status: .notIn)
            ],
            kind: .attempt
        ),
    ]),
    Game(masterWord: "BASIN", attempts: [ //done
        Code(
            characters: [
                Character(value: "T", status: .notIn),
                Character(value: "E", status: .notIn),
                Character(value: "R", status: .notIn),
                Character(value: "R", status: .notIn),
                Character(value: "A", status: .wrongPlace)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "T", status: .notIn),
                Character(value: "R", status: .notIn),
                Character(value: "A", status: .wrongPlace),
                Character(value: "S", status: .wrongPlace),
                Character(value: "H", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "B", status: .correct),
                Character(value: "A", status: .correct),
                Character(value: "K", status: .notIn),
                Character(value: "E", status: .notIn),
                Character(value: "D", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "B", status: .correct),
                Character(value: "O", status: .notIn),
                Character(value: "A", status: .wrongPlace),
                Character(value: "R", status: .notIn),
                Character(value: "D", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "B", status: .correct),
                Character(value: "A", status: .correct),
                Character(value: "S", status: .correct),
                Character(value: "I", status: .correct),
                Character(value: "N", status: .correct)
            ],
            kind: .attempt
        ),
    ]),
    Game(masterWord: "WORLD"), //hasn't started
]

