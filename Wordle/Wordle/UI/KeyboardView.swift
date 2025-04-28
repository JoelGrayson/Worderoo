//
//  KeyboardView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct KeyboardView: View {
    @Binding var game: Game
    
    let keys=[
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["ENTER", "Z", "X", "C", "V", "B", "N", "M", "DELETE"]
    ]
    
    var body: some View {
        VStack {
            ForEach(keys, id: \.self) { keyRow in
                HStack {
                    ForEach(keyRow, id: \.self) { key in
                        KeyView(key: key)
                    }
                }
            }
        }
    }
}

#Preview {
    KeyboardView(game: .constant(.init(startingWord: "HELLO", size: 5)))
}

