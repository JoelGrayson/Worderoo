//
//  Character.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Character {
    let value: String
    var status: Status
    
    init(value: String, status: Status = .hasCharButNotGuessedYet) {
        self.value = value
        self.status = status
    }
}


extension Character {
    static let blank = Character(value: " ", status: .blank)
}

