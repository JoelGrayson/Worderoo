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
        HStack {
            ForEach(0..<size, id: \.self) { chI in
                CharacterView(chI < code.characters.count ? code.characters[chI] : .blank)
            }
        }
    }
}



// The below code was an attempt to add selection, which I later realized was not necessary for this game
//struct CodeView: View {
//    var code: Code
//    let size: Int
//    @State var selection: Int? = nil
//    
//    init(for code: Code, size: Int) {
//        self.code = code
//        self.size = size
//        if code.kind == .guess {
//            self.selection = 0
//        }
//    }
//    
//    var body: some View {
//        HStack {
//            ForEach(0..<size, id: \.self) { chI in
//                let character = chI < code.characters.count ? code.characters[chI] : .blank
//                CharacterView(character)
//                    .onTapGesture {
//                        self.selection = chI
//                    }
//            }
//        }
//    }
//}

