//
//  WordleWordLoader.swift
//  Wordle
//
//  Created by Joel Grayson on 4/30/25.
//

import SwiftUI

let testMode = true //if testMode, always use WORLD as the word
let defaultWord = "WORLD"

// This struct only shows WordleView with the word. It manages procuring the words and is the source of truth not only for the words and master word but also the length of the master word
struct WordleWordLoader: View {
    @Environment(\.words) var words
    
    @State private var length = 5
    @State private var masterWord: String? = defaultWord
    
    var body: some View {
        Group {
            if let masterWord {
                WordleView(masterWord: masterWord, length: length, changeLength: { newLength in
                    length = newLength
                    selectWord()
                })
            } else {
                ProgressView()
            }
        }
        .onChange(of: words.count, initial: true) { oldValue, newValue in
            if words.count != 0 {
                if testMode {
                    masterWord = defaultWord
                } else {
                    selectWord()
                }
            }
        }
    }
    
    func selectWord() {
        masterWord = words.random(length: length)
        print("Selected", masterWord!)
    }
}

#Preview {
    WordleWordLoader()
}
