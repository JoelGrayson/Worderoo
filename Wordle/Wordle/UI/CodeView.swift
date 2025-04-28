//
//  CodeView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct CodeView: View {
    var code: Code
    
    init(for code: Code) {
        self.code = code
    }
    
    var body: some View {
        Text("Codes View")
        ForEach(code.characters.indices, id: \.self) { chI in
            CharacterView(code.characters[chI])
        }
    }
}

