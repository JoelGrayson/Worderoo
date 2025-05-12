//
//  WordleGamePicker.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct WordleGamePicker: View {
    @State private var games: [Game] = sampleGames
    @Environment(\.words) private var words
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(games.indices.reversed(), id: \.self) { i in
                    WordleView(game: $games[i])
                }
            }
        }
        
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

