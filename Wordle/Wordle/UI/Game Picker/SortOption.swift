//
//  SortOption.swift
//  Wordle
//
//  Created by Joel Grayson on 5/21/25.
//

enum SortOption: CaseIterable {
    case newestFirst
    case oldestFirst
    
    var title: String {
        switch self {
        case .newestFirst:
            return "Newest First"
        case .oldestFirst:
            return "Oldest First"
        }
    }
}

