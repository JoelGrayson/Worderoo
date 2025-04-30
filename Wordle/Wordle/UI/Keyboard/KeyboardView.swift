//
//  KeyboardView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct KeyboardView: View {
//    @Binding var game: Game
    let onKeyPress: (_ key: String) -> Void
    let getKeyStatus: (_ key: String) -> Status //used for coloring the keys
    
    static let keys=[
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L", "ENTER"],
        ["RESET", "Z", "X", "C", "V", "B", "N", "M", "DELETE"]
    ]
    
    var body: some View {
        VStack {
            ForEach(KeyboardView.keys, id: \.self) { keyRow in
                HStack {
                    ForEach(keyRow, id: \.self) { key in
                        KeyView(key: key, onKeyPress: onKeyPress, status: getKeyStatus(key))
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    KeyboardView(
//        game: .constant(.init(startingWord: "HELLO", size: 5)),
        onKeyPress: { key in
            print("Pressed", key)
        },
        getKeyStatus: { key in Status.blank }
   )
}

