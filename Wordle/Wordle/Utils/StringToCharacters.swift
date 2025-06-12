//
//  StringToCharacters.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

func stringToCharacters(_ input: String) -> [Character] {
    var out: [Character] = []
    for i in input.indices {
        let ch = input[i]
        out.append(
            Character(value: String(ch))
        )
    }
    return out
}
