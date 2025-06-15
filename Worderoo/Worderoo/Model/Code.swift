//
//  Code.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import Foundation

struct Code: Codable {
    var characters: [Character]
    var kind: Kind
    
    static let blank = Code.init(characters: [], kind: .attempt)
    
    var asString: String //not a computed property because SQL can't understand it and I want it to work with #Query's filter parameter
    
    mutating func setTo(_ to: String) {
        self.asString = to
        characters = to.split(separator: "").map({ ch in Character.init(value: String(ch), status: .blank) })
    }
    
    mutating func reset() {
        self.characters = []
        self.asString = ""
    }
    
    init(characters: [Character], kind: Kind) {
        self.characters = characters
        self.kind = kind
        self.asString = charactersToString(characters)
    }
    
    // Returns a code that has the graded characters for displaying
    // This is called when a guess is being turned into an attempt
    func guessToAttempt(gradedWith masterWord: String) -> Code {
        var gradedCharacters = [Character]()
        
        for (i, character) in characters.enumerated() {
            var gradedChar = character
            
            let guessedChar = character.value //★
            let masterWordI = masterWord.index(masterWord.startIndex, offsetBy: i)
            let masterWordChar = String(masterWord[masterWordI]) //★. character to string
            
            if masterWordChar == guessedChar { //in the right place
                gradedChar.status = .correct
            } else if masterWord.contains(guessedChar) { //in the wrong place but still in the word
                // Only N number of a character should be yellow if there are N times that character is misaligned
                let numInWrongPlace = masterWord.enumerated().count(where: { j, iteratedMasterChar in
                    let guessAtJ = characters[j].value
                    let masterAtJ = String(iteratedMasterChar)
                    
                    return masterAtJ == guessedChar //the correct answer is the guessedChar at position j
                        && guessAtJ != masterAtJ //but at position j, the guess is not right
                })
                let numAlreadyYellow = gradedCharacters.count(where: { ch in
                    ch.value == guessedChar && ch.status == .wrongPlace
                })
                if numInWrongPlace > numAlreadyYellow {
                    gradedChar.status = .wrongPlace
                } else {
                    gradedChar.status = .notIn
                }
            } else {
                gradedChar.status = .notIn
            }
            gradedCharacters.append(gradedChar)
        }
        return Code(characters: gradedCharacters, kind: .attempt)
    }
}

func charactersToString(_ characters: [Character]) -> String {
    characters
        .map({ ch in ch.value }) //extract the value
        .joined(separator: "") //join the characters into a string
    // characters.reduce("", { result, acc in result + acc.value })
}

func codeToString(_ code: Code) -> String {
    return charactersToString(code.characters)
}

