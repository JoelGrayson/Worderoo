//
//  IsValidWord.swift
//  Wordle
//
//  Created by Joel Grayson on 5/1/25.
//

import SwiftUI //might not be necessary
import Foundation

let words = wordsString
    .split(separator: "\n")
    .map(String.init)

func isValidWord(_ word: String) -> Bool {
    words.contains(word)
}

