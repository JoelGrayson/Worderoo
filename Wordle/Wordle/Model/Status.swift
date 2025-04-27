//
//  Status.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

enum Status {
    // Not guessed yet
    case nothing
    
    // Guessed and the status is calculated
    case correct //will show green
    case wrongPlace //will show yellow
    case blank //will show dark gray
}

