//
//  Styles.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct Styles {
    static let keyColor = Color.lightGray
    static let keyCornerRadius: CGFloat = 12
    static let cellSize: CGFloat = 50
    static let cellFontSize: CGFloat = 35

    
    static func statusToColor(_ status: Status) -> Color {
        switch (status) {
        case .hasCharButNotGuessedYet:
            return .middleGray
        case .blank:
            return keyColor
        case .correct:
            return .green
        case .wrongPlace:
            return .yellow
        case .notIn:
            return .darkGray
        }
    }
}

extension Color {
    static let lightGray = Color.gray(0.8)
    static let middleGray = Color.gray(0.6)
    static let darkGray = Color.gray(0.3)
}

