//
//  Code.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Code {
    let characters: [Character]
    let kind: Kind
}


enum Kind {
    case master //correct answer
    case guess //user typing in
    case attempt //user typed in earlier and it has been graded now
}

