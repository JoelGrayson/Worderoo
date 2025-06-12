//
//  Code.swift
//  Wordle
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
            var gradedCharacter = character
            
            let guessedCharacter = character.value
            let masterWordI = masterWord.index(masterWord.startIndex, offsetBy: i)
            let masterWordChar = String(masterWord[masterWordI]) //character to string
            
//            print(guessedCharacter, masterWordChar, masterWord.contains(character.value) )
            
            if masterWordChar == guessedCharacter { //in the right place
                gradedCharacter.status = .correct
            } else if masterWord.contains(guessedCharacter) { //in the wrong place but still in the word
                let numLettersInAnswer = masterWord.count(where: { ch in String(ch) == guessedCharacter })
                let numAlreadyGuessed = characters.count(where: { $0.value == guessedCharacter })
                if numLettersInAnswer > numAlreadyGuessed {
                    gradedCharacter.status = .wrongPlace
                }
            } else {
                gradedCharacter.status = .notIn
            }
            gradedCharacters.append(gradedCharacter)
        }
        return Code(characters: gradedCharacters, kind: .attempt)
    }
}

func charactersToString(_ characters: [Character]) -> String {
    return characters
        .map({ ch in ch.value }) //extract the value
        .joined(separator: "") //join the characters into a string
}

func codeToString(_ code: Code) -> String {
    return charactersToString(code.characters)
}

