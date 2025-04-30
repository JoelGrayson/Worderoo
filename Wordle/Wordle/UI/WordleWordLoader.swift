//
//  WordleWordLoader.swift
//  Wordle
//
//  Created by Joel Grayson on 4/30/25.
//

import SwiftUI

struct WordleWordLoader: View {
    @Environment(\.words) var words
    
    let masterWord: String? = "WORLD"
    
    var body: some View {
        if let masterWord {
            WordleView(startingMasterWord: masterWord)
        } else {
            ProgressView()
        }
    }
}

#Preview {
    WordleWordLoader()
}
