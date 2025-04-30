//
//  WordleWordLoader.swift
//  Wordle
//
//  Created by Joel Grayson on 4/30/25.
//

import SwiftUI

struct Settings {
    static let testMode = false //if testMode, always use WORLD as the word
    static let defaultWord = "WORLD"
    static let startingWordSize = 5
    static var checkIfEnglishWord: Bool { //because the list of English words is not complete
        if testMode {
            true //can be set to false if it gets annoying
        } else {
            true
        }
    }
}

// This struct only shows WordleView with the word. It manages procuring the words and is the source of truth not only for the words and master word but also the length of the master word
struct WordleWordLoader: View {
    @Environment(\.words) var words
    
    @State private var length = 5
    @State private var masterWord: String? = Settings.defaultWord
    
    var body: some View {
        Group {
            if let masterWord {
                WordleView(
                    masterWord: masterWord,
                    length: length,
                    changeWord: selectWord,
                    changeLength: { newLength in
                        length = newLength
                    }
                )
            } else {
                ProgressView()
            }
        }
        .onChange(of: words.count, initial: true) { oldValue, newValue in
            print("Hi")
            if words.count != 0 {
                if Settings.testMode {
                    masterWord = Settings.defaultWord
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
