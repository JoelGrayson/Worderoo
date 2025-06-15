//
//  GameList.swift
//  Worderoo
//
//  Created by Joel Grayson on 5/21/25.
//

import SwiftUI
import SwiftData

struct GameList: View {
    @Environment(\.modelContext) var modelContext
    
    var sortBy: SortOption
    var searchString: String
    var onlyShowIncompleteGames: Bool
    @Binding var showTop: Bool
    
    // Settings
    @Query private var configurableSettings: [ConfigurableSettings]
    
    var configurableSettingsWrapper: ConfigurableSettings {
        if let s = configurableSettings.first {
            s
        } else {
            defaultConfigurableSettings
        }
    }
    
    // Game
    @Query private var rawGames: [Game]
    var games: [Game] { //filtered and sorted
        rawGames
            .filter { game in
                let searchStringGood = if searchString != "" {
                    game.attempts.contains(where: { attempt in
                        charactersToString(attempt.characters)
                            .lowercased()
                            .contains(searchString.lowercased().trimmingCharacters(in: .whitespacesAndNewlines))
                    })
                } else {
                    true
                }
                
                let onlyShowIncompleteGamesGood = if onlyShowIncompleteGames {
                    !game.isOver
                } else {
                    true
                }
                
                return searchStringGood && onlyShowIncompleteGamesGood
            }
            .sorted(by: { a, b in
                let aT = a.lastGuessedAt
                let bT = b.lastGuessedAt
                
                if sortBy == .newestFirst {
                    return aT > bT
                } else {
                    return aT < bT
                }
            })
    }
    
    @State private var selectedGame: Game?
    
    
    var body: some View {
        VStack {
            NavigationSplitView(columnVisibility: .constant(.all)) {
                gamesListPane
            } detail: {
                gamePane
            }
            .onChange(of: rawGames) { //Game deleted so remove selection
                if let selectedGame, !rawGames.contains(selectedGame) {
                    self.selectedGame = nil
                }
            }
            .onChange(of: selectedGame) {
                showTop = selectedGame == nil
            }
            .navigationSplitViewStyle(.balanced)
            // Adding sample games in test mode
            //        .onAppear {
            //            if games.isEmpty {
            //                for game in sampleGames {
            //                    modelContext.insert(game)
            //                }
            //            }
            //        }
        }
        .padding(.top)
    }
    
    var gamesListPane: some View {
        return Group {
            // Empty list of games if appropriate
            if games.isEmpty {
                Group {
                    if searchString != "", rawGames.isEmpty {
                        Text("No games found containing the search query \"\(searchString)\"")
                    } else {
                        Text("No games found")
                    }
                }
                .padding(.top, Constants.noGamesPadding)
            }
            // List of Games
            List(games, selection: $selectedGame) { game in //received help from AI on making the bindings work
                NavigationLink(value: game) {
                    GamePreview(game: game, configurableSettings: configurableSettingsWrapper)
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
            
            
            // New Game Button
            Button("New Game", systemImage: "plus.circle.fill") {
                let newWord = if HardCodedSettings.testMode {
                    HardCodedSettings.defaultWord
                } else {
                    selectWord()
                }
                if let newWord {
                    print("Selected", newWord.uppercased(), "as the new word")
                    withAnimation {
                        let newGame = Game(masterWord: newWord)
                        modelContext.insert(newGame)
                        selectedGame = newGame
                    }
                } else {
                    print("No word could be selected")
                    // Alert(title: "Could not add game", )
                    print("Could not add game")
                }
            }
            .padding(.vertical)
        }
    }
    
    var gamePane: some View {
        return Group {
            if let selectedGame {
                // Got help from AI on this one
                GameView(
                    configurableSettings: configurableSettingsWrapper,
                    game: selectedGame,
                    onDisappear: {
                        onDisappearHandler(game: selectedGame)
                    },
                    onAppear: {
                        onAppearHandler(game: selectedGame)
                    },
                    endGame: {
                        selectedGame.endTime = .now
                        selectedGame.pausedAt = nil
                    },
                    typeCharacter: { key in
                        selectedGame.guess.characters.append(.init(value: key))
                    },
                    deleteCharacter: {
                        selectedGame.guess.characters.remove(
                            at: selectedGame.guess.characters.index(
                                selectedGame.guess.characters.endIndex,
                                offsetBy: -1
                            )
                        )
                    }
                )
                .onChange(of: selectedGame) { oldGame, newGame in
                    // old onDisappear
                    onDisappearHandler(game: oldGame)
                    
                    // old onAppear
                    onAppearHandler(game: newGame)
                }
                .onChange(of: selectedGame.masterWord) {
                    // Ensure that the master word of the game and the characters are in sync
                    selectedGame.master.characters = stringToCharacters(selectedGame.masterWord)
                    selectedGame.master.asString = selectedGame.masterWord
                }
            } else {
                Text("Choose a Game")
            }
        }
    }
    
    func selectWord(ofLength length: Int = -1) -> String? {
        let lengthToUse = length == -1 ? configurableSettingsWrapper.wordSizeForNewGames : length
        let newWord: String? = MasterWordChoices.random(length: lengthToUse)
        return newWord
    }
    
    func deleteGame(_ game: Game) {
        let gameToRemove = rawGames.first(where: { el in
            el == game
        })
        
        if let gameToRemove {
            modelContext.delete(gameToRemove)
        }
    }
    
    func onAppearHandler(game: Game) {
        if let pausedAt = game.pausedAt {
            let pausedForDuration = Date.now.timeIntervalSince(pausedAt)
            print("onAppear had pausedAt for", pausedForDuration)
            game.startTime = game.startTime.advanced(by: pausedForDuration)
            game.pausedAt = nil
        }
    }
    
    func onDisappearHandler(game: Game) {
        game.pausedAt = .now
    }
}

#Preview {
    GameList(sortBy: .newestFirst, searchString: "", onlyShowIncompleteGames: true, showTop: .constant(true))
}

