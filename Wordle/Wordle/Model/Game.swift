//
//  Game.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Game {
    let size: Int
    let masterWord: String
    let master: Code
    let guess: Code
    let attempts: [Code]
    
    init(startingWord: String, size: Int) {
        self.size = size
        masterWord = startingWord.uppercased()
        master = Code(characters: stringToCharacters(masterWord), kind: .master)
        guess = Code(characters: [], kind: .guess)
        attempts = []
    }
}

