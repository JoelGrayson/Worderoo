//
//  isEnglishWord.swift
//  Worderoo
//
//  Created by Joel Grayson on 5/12/25.
//

import Foundation
// Used ChatGPT to support this with AppKit (macOS) in addition to UIKit (iPhone/iPad)
#if canImport(UIKit)
import UIKit

// Followed Paul Hudson's tutorial: https://www.youtube.com/watch?v=Z0TzefG4wdw
func isEnglishWord(_ word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
}

#elseif canImport(AppKit)
import AppKit

func isEnglishWord(_ word: String) -> Bool {
    let checker = NSSpellChecker.shared
    let misspelled = checker.checkSpelling(of: word, startingAt: 0)
    return misspelled.location == NSNotFound
}

#endif


