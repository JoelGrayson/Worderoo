//
//  Settings.swift
//  Wordle
//
//  Created by Joel Grayson on 4/30/25.
//

import SwiftUI
import SwiftData

let defaultConfigurableSettings = ConfigurableSettings()

@Model
class ConfigurableSettings { //here are the default settings
    var wordSizeForNewGames: Int
    var numGuessesAllowed: Int
    var checkIfEnglishWord: Bool
    var onlyShowIncompleteGames: Bool
    
    // Initialize by choosing all params
    init(wordSizeForNewGames: Int = 5, numGuessesAllowed: Int = 6, checkIfEnglishWord: Bool = true, onlyShowIncompleteGames: Bool = false) {
        self.wordSizeForNewGames = wordSizeForNewGames
        self.numGuessesAllowed = numGuessesAllowed
        self.checkIfEnglishWord = checkIfEnglishWord
        self.onlyShowIncompleteGames = onlyShowIncompleteGames
    }
    
    // Copy initializer
    init(_ configurableSettingsToCopy: ConfigurableSettings) {
        self.wordSizeForNewGames = configurableSettingsToCopy.wordSizeForNewGames
        self.numGuessesAllowed = configurableSettingsToCopy.numGuessesAllowed
        self.checkIfEnglishWord = configurableSettingsToCopy.checkIfEnglishWord
        self.onlyShowIncompleteGames = configurableSettingsToCopy.onlyShowIncompleteGames
    }
}

struct HardCodedSettings { //related to test mode
    static let testMode = false //if testMode, always use WORLD as the word
    static let defaultWord = "WORLD"
    static let showAnswer = false
}

