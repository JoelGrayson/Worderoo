//
//  Settings.swift
//  Worderoo
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
    var hapticFeedback: Bool
    
    // Initialize by choosing all params
    init(wordSizeForNewGames: Int = 5, numGuessesAllowed: Int = 6, checkIfEnglishWord: Bool = true, onlyShowIncompleteGames: Bool = false, hapticFeedback: Bool = true) {
        self.wordSizeForNewGames = wordSizeForNewGames
        self.numGuessesAllowed = numGuessesAllowed
        self.checkIfEnglishWord = checkIfEnglishWord
        self.onlyShowIncompleteGames = onlyShowIncompleteGames
        self.hapticFeedback = hapticFeedback
    }
    
    // Copy initializer
    init(_ configurableSettingsToCopy: ConfigurableSettings) {
        self.wordSizeForNewGames = configurableSettingsToCopy.wordSizeForNewGames
        self.numGuessesAllowed = configurableSettingsToCopy.numGuessesAllowed
        self.checkIfEnglishWord = configurableSettingsToCopy.checkIfEnglishWord
        self.onlyShowIncompleteGames = configurableSettingsToCopy.onlyShowIncompleteGames
        self.hapticFeedback = configurableSettingsToCopy.hapticFeedback
    }
}

// NOTE: in production vs. development configured here
struct HardCodedSettings { //related to test mode. Not configurable.
    static let testMode = true //if testMode, always use defaultWord as the word
    static let defaultWord = "AABBC"
    static let showAnswer = false
}

