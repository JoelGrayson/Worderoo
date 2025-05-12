//
//  GameList.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct GameList: View {
    @Binding var games: [Game]
    
    var body: some View {
        List {
            ForEach(games.indices.reversed(), id: \.self) { i in
//                NavigationLink(value: games[i]) {
                    GamePreview(game: $games[i])
//                }
            }
        }
    }
}
