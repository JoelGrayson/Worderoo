//
//  Styles.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct Styles {
    static let keyCornerRadius: CGFloat = 12
    static let keyHeight: CGFloat = 35
    static let keySeparation: CGFloat = 5
    
    static let cellSize: CGFloat = 50
    static let cellFontSize: CGFloat = 35
    static let animation = Animation.easeInOut(duration: 0.3)
    
    static let closeIconSize = 8 as CGFloat
    static let closeIconPadding = 23 as CGFloat
    
    static let horizontalSpacing = 12 as CGFloat
    
    static func statusToColor(_ status: Status) -> Color {
        switch (status) {
        case .hasCharButNotGuessedYet:
            return .middleGray
        case .blank:
            return .lightGray
        case .correct:
            return .green
        case .wrongPlace:
            return .yellow
        case .notIn:
            return .darkGray
        }
    }
}

extension Color { // CM4
    static let lightGray = Color.gray(0.8)
    static let middleGray = Color.gray(0.6)
    static let darkGray = Color.gray(0.3)
}

