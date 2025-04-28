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
            CodeView(for: game.guess)
            ForEach(game.attempts.indices, id: \.self) { i in //received help from https://www.hackingwithswift.com/forums/swiftui/compiler-warning-non-constant-range-argument-must-be-an-integer-literal/14878
                CodeView(for: game.attempts[i])
            }
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
