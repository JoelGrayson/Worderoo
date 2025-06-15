//
//  View+conditionalHapticFeedback.swift
//  Worderoo
//
//  Created by Joel Grayson on 6/15/25.
//

import SwiftUI

extension View {
    func conditionalHapticFeedback(condition: Bool, trigger: Int) -> some View {
        Group {
            if condition {
                self.sensoryFeedback(.selection, trigger: trigger)
            } else {
                self
            }
        }
    }
}

