//
//  Code.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Code {
    var characters: [Character]
    var kind: Kind
    
    static let blank = Code.init(characters: [], kind: .attempt)
    
    func toString() -> String {
        return characters
            .map({ ch in ch.value }) //extract the value
            .joined(separator: "") //join the characters into a string
    }
    
    mutating func setTo(_ to: String) {
        characters = to.split(separator: "").map({ ch in Character.init(value: String(ch), status: .blank) })
    }
    
    mutating func reset() {
        self.characters = []
    }
    
    // Returns a code that has the graded characters for displaying
    // This is called when a guess is being turned into an attempt
    func guessToAttempt(gradedWith masterWord: String) -> Code {
        var gradedCharacters = [Character]()
        for var character in characters {
            character.status = .correct
            gradedCharacters.append(character)
        }
        return Code(characters: gradedCharacters, kind: .attempt)
    }
}


enum Kind {
    case master //correct answer
    case guess //user typing in
    case attempt //user typed in earlier and it has been graded now
}

