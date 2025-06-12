//
//  UIExtensions.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

extension View {
    // Used AI to make this view modifier only work on iPad because .plain looks good on iPad but bad on iPhone
    @ViewBuilder
    func ipadListLooksGood() -> some View {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.listStyle(.plain)
        } else {
            self
        }
    }
}


extension Color { // CM4
    static func gray(_ brightness: CGFloat) -> Color {
        return Color(hue: 0, saturation: 0, brightness: brightness)
    }
}

