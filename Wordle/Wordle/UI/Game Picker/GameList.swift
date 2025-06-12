//
//  GameList.swift
//  Wordle
//
//  Created by Joel Grayson on 5/21/25.
//

import SwiftUI
import SwiftData

struct GameList: View {
    @Environment(\.words) private var words
    @Environment(\.modelContext) var modelContext

    @Binding var showTop: Bool
    
    // Game
    @Query private var games: [Game]
    @State private var selectedGame: Game?
    
    
    // Settings
    @Query private var configurableSettings: [ConfigurableSettings]
    
    var configurableSettingsWrapper: ConfigurableSettings {
        if let s = configurableSettings.first {
            s
        } else {
            defaultConfigurableSettings
        }
    }
    
    
    init(sortBy: SortOption, searchString: String, onlyShowIncompleteGames: Bool, showTop: Binding<Bool>) {
        print("Sorting by \(sortBy) and search string >\(searchString)< with onlyShowIncompleteGames=\(onlyShowIncompleteGames)")
        let predicate = #Predicate<Game> { game in
            ( //Incomplete games clause
                onlyShowIncompleteGames
                    ? !game.isOver //if only show incomplete games setting is enabled, do this
                    : true //otherwise, show all
            )
            &&
            ( //Search string clause
                searchString != ""
                    ? game.attempts.contains(where: { code in //if there is a search string, only show those that match the search string
                        code.asString.contains(searchString)
                    })
                    : true //if no search string, show all games
            )
        }
        
        let order = if sortBy == SortOption.newestFirst {
            SortOrder.forward
        } else {
            SortOrder.reverse
        }
        
        _games = Query(filter: predicate, sort: \Game.lastGuessMadeAt, order: order)
        
        self._showTop = showTop //got help from AI on this one
    }
    
    var body: some View {
        NavigationSplitView(columnVisibility: .constant(.all)) {
            // Title which is used in place of navigationTitle and toolbar because the latter acts strangely alignment-wise
            
            // Empty list of games if appropriate
            if games.isEmpty {
                Text("No games.")
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
            .padding(.top)
            .padding(.vertical)
        } detail: {
            if let selectedGame = selectedGame {
                // Got help from AI on this one
                WordleView(game:
                    Binding<Game>(
                        get: { selectedGame },
                        set: { self.selectedGame = $0 } //updates the game
                    ),
                   configurableSettings: configurableSettingsWrapper
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
        .onChange(of: selectedGame) {
            showTop = selectedGame == nil
        }
        .navigationSplitViewStyle(.balanced)
//        .onAppear {
//            if games.isEmpty {
//                for game in sampleGames {
//                    modelContext.insert(game)
//                }
//            }
//        }
    }
    
    func selectWord(ofLength length: Int = -1) -> String? {
        let lengthToUse = length == -1 ? configurableSettingsWrapper.wordSizeForNewGames : length
        let newWord: String? = words.random(length: lengthToUse)
        print("Selected", newWord ?? "no word selected")
        return newWord
    }
    
    func deleteGame(_ game: Game) {
        let gameToRemove = games.first(where: { el in
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

