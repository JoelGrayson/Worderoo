//
//  CharacterView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct CharacterView: View {
    let character: Character
    
    init(_ character: Character) {
        self.character = character
    }
    
    var body: some View {
        Text(character.value)
//            .padding()
            .frame(width: Styles.cellSize, height: Styles.cellSize) // Q: how do I avoid using a frame for this while keeping a square?
            .font(.system(size: Styles.cellFontSize))
            .monospaced()
            .bold()
            .background(
                Styles.statusToColor(character.status)
            )
    }
}

#Preview {
    HStack {
        CharacterView(.init(value: "A"))
        CharacterView(.init(value: "B"))
        CharacterView(.init(value: "C"))
        CharacterView(.blank)
    }
}
