//
//  Words.swift
//  CodeBreaker
//
//  Created by CS193p Instructor on 4/14/25.
//

import SwiftUI

extension EnvironmentValues {
    @Entry var words = Words.shared
}

@Observable
class Words {
    private var words = Dictionary<Int, Set<String>>() //length of word -> set of words that meet that length
    
    static let shared =
        Words(from: URL(string: "https://web.stanford.edu/class/cs193p/common.words")) //Singleton of Words. URL is text file of words separated by newline

    private init(from url: URL? = nil) { //private init prevents the developer from accidentally initializing another Words, since it follows the singleton pattern
        Task {
            var _words = [Int: Set<String>]() //[Int: Set<String>]() is the same as Dictionary<Int, Set<String>>()
            if let url {
                do {
                    for try await word in url.lines {
                        _words[word.count, default: Set<String>()].insert(word.uppercased())
                    }
                } catch {
                    print("Words could not load words from \(url): \(error)")
                }
            }
            words = _words
            if count > 0 {
                print("Words loaded \(count) words from \(url?.absoluteString ?? "nil")")
            }
        }
    }
    
    var count: Int { //total number of words. Gets numel for a 2D tensor
        words.values.reduce(0) { $0 + $1.count }
    }
    
    func contains(_ word: String) -> Bool {
        words[word.count]?.contains(word.uppercased()) == true
    }

    func random(length: Int) -> String? {
        let word = words[length]?.randomElement()
        if word == nil {
            print("Words could not find a random word of length \(length)")
        }
        return word
    }
}
