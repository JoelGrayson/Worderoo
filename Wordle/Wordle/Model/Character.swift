//
//  Character.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Character {
    let value: String
    let status: Status
    
    init(value: String, status: Status = .nothing) {
        self.value = value
        self.status = status
    }
}

