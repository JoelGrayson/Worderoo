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
                    game.isOver
                } else {
                    true
                }
                
                return searchStringGood && onlyShowIncompleteGamesGood
            }
            .sorted(by: { a, b in
                if let aSt = a.startTime, let bSt = b.startTime {
                    if sortBy == .newestFirst {
                        return aSt < bSt
                    } else {
                        return aSt > bSt
                    }
                } else {
                    return true //no information known
                }
            })
    }
    
    @State private var selectedGame: Game?
    
    
    var body: some View {
        VStack {
            NavigationSplitView(columnVisibility: .constant(.all)) {
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
                    let newWord = selectWord()
                    if let newWord {
                        withAnimation {
                            let newGame = Game(masterWord: HardCodedSettings.testMode ? HardCodedSettings.defaultWord : newWord)
                            modelContext.insert(newGame)
                            selectedGame = newGame
                        }
                    } else {
                        // Alert(title: "Could not add game", )
                        print("Could not add game")
                    }
                }
            } detail: {
                if let selectedGame = selectedGame {
                    // Got help from AI on this one
                    GameView(game:
                                Binding<Game>(
                                    get: { selectedGame },
                                    set: { self.selectedGame = $0 } //updates the game
                                ),
                             configurableSettings: configurableSettingsWrapper
                    )
                    //.navigationBarTitleDisplayMode(.inline)   // ① regular bar
                    //                .toolbarBackground(.visible, for: .navigationBar) // ② give it a solid bg if you like
                    //                .safeAreaInset(edge: .top) { Spacer().frame(height: 8) } //fix the padding issue
                } else {
                    Text("Choose a Game")
                }
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
    
    func selectWord(ofLength length: Int = -1) -> String? {
        let lengthToUse = length == -1 ? configurableSettingsWrapper.wordSizeForNewGames : length
        let newWord: String? = MasterWordChoices.random(length: lengthToUse)
        print("Selected", newWord ?? "no word selected")
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
}

#Preview {
    GameList(sortBy: .newestFirst, searchString: "", onlyShowIncompleteGames: true, showTop: .constant(true))
}

