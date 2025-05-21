//
//  Settings.swift
//  Wordle
//
//  Created by Joel Grayson on 4/30/25.
//

import SwiftUI
import SwiftData

let defaultNumGuessesAllowed = 6

let defaultConfigurableSettings = ConfigurableSettings()

@Model
class ConfigurableSettings { //here are the default settings
    var wordSizeForNewGames: Int
    var numGuessesAllowed: Int
    var checkIfEnglishWord: Bool
    
    init(wordSizeForNewGames: Int = 5, numGuessesAllowed: Int = defaultNumGuessesAllowed, checkIfEnglishWord: Bool = true) {
        self.wordSizeForNewGames = wordSizeForNewGames
        self.numGuessesAllowed = numGuessesAllowed
        self.checkIfEnglishWord = checkIfEnglishWord
    }
    
    init(_ configurableSettingsToCopy: ConfigurableSettings) {
        self.wordSizeForNewGames = configurableSettingsToCopy.wordSizeForNewGames
        self.numGuessesAllowed = configurableSettingsToCopy.numGuessesAllowed
        self.checkIfEnglishWord = configurableSettingsToCopy.checkIfEnglishWord
    }
}

struct HardCodedSettings { //related to test mode
    static let testMode = false //if testMode, always use WORLD as the word
    static let defaultWord = "WORLD"
    static let showAnswer = false
}

//// This struct only shows WordleView with the word. It manages procuring the words and is the source of truth not only for the words and master word but also the length of the master word
//struct WordleWordLoader: View {
//    @Environment(\.words) var words
//    
//    @State private var masterWord: String?
//    
//    var body: some View {
//        Group {
//            if let masterWord {
//                WordleView(
//                    masterWord: masterWord,
//                    selectWord: selectWord
//                )
//            } else {
//                ProgressView()
//            }
//        }
//        .onAppear {
//            if Settings.testMode {
//                masterWord = Settings.defaultWord
//            }
//        }
//        .onChange(of: words.count, initial: true) { oldValue, newValue in
//            if masterWord == nil { //setting the master word for the first time
//                if Settings.testMode {
//                    masterWord = Settings.defaultWord
//                } else {
//                    if words.count != 0 {
//                        selectWord(ofLength: Settings.wordSizeForNewGames) //size has not been specified since this is the first time
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    WordleWordLoader()
//}
