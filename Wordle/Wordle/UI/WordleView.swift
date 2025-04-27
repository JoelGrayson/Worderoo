//
//  WordleView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct WordleView: View {
    @Environment(\.words) var words
    @State private var game = Game(startingWord: "World")
    
    var body: some View {
        VStack {
            CodesView(game: $game) // a code is a single line (list of characters)
            KeyboardView(game: $game)
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
