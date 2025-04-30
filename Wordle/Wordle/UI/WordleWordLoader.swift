//
//  WordleWordLoader.swift
//  Wordle
//
//  Created by Joel Grayson on 4/30/25.
//

import SwiftUI

struct Settings {
    static let startingWordSize = 5
    static var checkIfEnglishWord: Bool { //because the list of English words is not complete
        if testMode {
            true //can be set to false if it gets annoying
        } else {
            true
        }
    }
    
    // Test mode
    static let testMode = false //if testMode, always use WORLD as the word
    static let defaultWord = "WORLD"
    static let showAnswer = true
}

// This struct only shows WordleView with the word. It manages procuring the words and is the source of truth not only for the words and master word but also the length of the master word
struct WordleWordLoader: View {
    @Environment(\.words) var words
    
    @State private var masterWord: String?
    
    var body: some View {
        Group {
            if let masterWord {
                WordleView(
                    masterWord: masterWord,
                    selectWord: selectWord
                )
            } else {
                ProgressView()
            }
        }
        .onAppear {
            if Settings.testMode {
                masterWord = Settings.defaultWord
            }
        }
        .onChange(of: words.count, initial: true) { oldValue, newValue in
            print("Hi")
            if masterWord == nil { //setting the master word for the first time
                if Settings.testMode {
                    masterWord = Settings.defaultWord
                } else {
                    if words.count != 0 {
                        selectWord(ofLength: Settings.startingWordSize) //size has not been specified since this is the first time
                    }
                }
            }
        }
    }
    
    func selectWord(ofLength length: Int) {
        masterWord = words.random(length: length)
        print("Selected", masterWord ?? "no word selected")
    }
}

#Preview {
    WordleWordLoader()
}
