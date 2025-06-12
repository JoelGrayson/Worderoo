//
//  isEnglishWord.swift
//  Worderoo
//
//  Created by Joel Grayson on 5/12/25.
//

import Foundation
import UIKit

// Followed Paul Hudson's tutorial: https://www.youtube.com/watch?v=Z0TzefG4wdw
func isEnglishWord(_ word: String) -> Bool {
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
    
    return misspelledRange.location == NSNotFound
}

