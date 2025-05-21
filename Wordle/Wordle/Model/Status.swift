//
//  Status.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

enum Status: Codable {
    // Not guessed yet
    case blank //empty space
    case hasCharButNotGuessedYet
    
    // Graded: guessed and the status is calculated
    case correct //will show green
        // analogous to .exact
    case wrongPlace //will show yellow
        // analogous to .inexact
    case notIn //will show dark gray
}

