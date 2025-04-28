//
//  CodeView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct CodeView: View {
    var code: Code
    let size: Int
    
    init(for code: Code, size: Int) {
        self.code = code
        self.size = size
    }
    
    var body: some View {
        Text("Codes View")
        ForEach(0..<size, id: \.self) { chI in
            CharacterView(chI < code.characters.count ? code.characters[chI] : .blank)
        }
    }
}

