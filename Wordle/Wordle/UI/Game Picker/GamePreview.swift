//
//  GamePreview.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct GamePreview: View {
    var game: Game
    var configurableSettings: ConfigurableSettings
    
    var body: some View {
        VStack(alignment: .trailing) {
            Group {
                if let lastAttempt = game.attempts.last {
                    CodeView(for: lastAttempt, size: lastAttempt.characters.count)
                } else {
                    CodeView(for: GamePreview.blankCode, size: game.size)
                }
            }
            
            Text("\(game.attempts.count)/\(configurableSettings.numGuessesAllowed) tries")
        }
        .padding(.top)
    }
    
    static let blankCode = Code(characters: [], kind: .attempt)
}

#Preview {
    GamePreview(game: sampleGames.first!, configurableSettings: ConfigurableSettings())
}
