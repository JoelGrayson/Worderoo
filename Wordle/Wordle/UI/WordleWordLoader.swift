//
//  WordleWordLoader.swift
//  Wordle
//
//  Created by Joel Grayson on 4/30/25.
//

import SwiftUI

struct WordleWordLoader: View {
    @Environment(\.words) var words
    
    @State private var masterWord: String? = "WORLD"
    
    var body: some View {
        Group {
            if let masterWord {
                WordleView(startingMasterWord: masterWord)
            } else {
                ProgressView()
            }
        }
        .onChange(of: words.count, initial: true) { oldValue, newValue in
            if words.count != 0 {
                selectWord()
            }
        }
    }
    
    func selectWord() {
        masterWord = words.random(length: 5)
        print("Selected", masterWord!)
    }
}

#Preview {
    WordleWordLoader()
}
