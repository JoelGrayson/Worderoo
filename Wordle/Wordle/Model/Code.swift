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
    
    mutating func reset() {
        self.characters = []
    }
}


enum Kind {
    case master //correct answer
    case guess //user typing in
    case attempt //user typed in earlier and it has been graded now
}

