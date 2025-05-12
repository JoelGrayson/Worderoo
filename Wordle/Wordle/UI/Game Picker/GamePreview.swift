//
//  GamePreview.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct GamePreview: View {
    var game: Game
    
    var body: some View {
        HStack(alignment: .bottom) {
            Group {
                if let lastAttempt = game.attempts.last {
                    CodeView(for: lastAttempt, size: lastAttempt.characters.count)
                } else {
                    CodeView(for: GamePreview.blankCode, size: game.size)
                }
            }
            
            VStack {
                Text("\(game.attempts.count)/\(game.size) tries")
            }
        }
    }
    
    static let blankCode = Code(characters: [], kind: .attempt)
}

#Preview {
    GamePreview(game: sampleGames.first!)
}
