//
//  Styles.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct Styles {
    static let keyColor = Color.gray(0.8)
    static let keyCornerRadius: CGFloat = 12
    static func statusToColor(_ status: Status) -> Color {
        switch (status) {
        case .nothing:
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
    static let darkGray = Color.gray(0.3)
}

