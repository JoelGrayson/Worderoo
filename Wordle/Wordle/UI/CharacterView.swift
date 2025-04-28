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
            .background(
                
            )
    }
}

#Preview {
    CharacterView(.init(value: "A"))
}
