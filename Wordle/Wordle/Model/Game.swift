//
//  Game.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Game {
    let master: Code
    let guess: Code
    let attempts: [Code]
    
    init(startingWord: String) {
        master = Code(characters: stringToCharacters(startingWord), kind: .master)
        guess = Code(characters: [], kind: .guess)
        attempts = []
    }
}

