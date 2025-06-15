//
//  GamePreview.swift
//  Worderoo
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
            
            HStack {
                let startTime = game.startTime
                
                if let endTime = game.endTime {
                    Text(endTime, format: .offset(to: startTime, allowedFields: [.minute, .second]))
                } else {
                    if let pausedAt = game.pausedAt {
                        Text(pausedAt, format: .offset(to: startTime, allowedFields: [.minute, .second]))
                    } else {
                        Text("") //has not started yet because hasn't exited the game yet
                    }
                }
                Text("\(game.attempts.count)/\(configurableSettings.numGuessesAllowed) tries")
            }
        }
        .padding(.top)
    }
    
    static let blankCode = Code(characters: [], kind: .attempt)
}

