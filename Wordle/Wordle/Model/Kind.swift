//
//  Kind.swift
//  Wordle
//
//  Created by Joel Grayson on 5/21/25.
//

enum Kind: Codable {
    case master //correct answer
    case guess //user typing in
    case attempt //user typed in earlier and it has been graded now
}

