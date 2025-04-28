//
//  Game.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Game {
    var size: Int //horizontal length of each word
    var masterWord: String
    var master: Code
    var guess: Code
    var attempts: [Code]
    
    static let numGuessesAllowed = 6
    
    init(startingWord: String, size: Int) {
        self.size = size
        masterWord = startingWord.uppercased()
        master = Code(characters: stringToCharacters(masterWord), kind: .master)
        guess = Code(characters: [], kind: .guess)
        attempts = []
    }
}

