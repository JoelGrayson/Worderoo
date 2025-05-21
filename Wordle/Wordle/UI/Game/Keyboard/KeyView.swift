//
//  KeyView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct KeyView: View {
    let key: String
    let onKeyPress: (_ key: String) -> Void
    let status: Status
    
    init(key: String, onKeyPress: @escaping (_: String) -> Void, status: Status = .blank) {
        self.key = key
        self.onKeyPress = onKeyPress
        self.status = status
    }
    
    var body: some View {
        Rectangle()
            .padding(.horizontal, Constants.horizontalPadding)
            .padding(.vertical, Constants.verticalPadding)
            .foregroundStyle(Styles.statusToColor(status))
            .background(Styles.statusToColor(status))
            .clipShape(RoundedRectangle(cornerRadius: Styles.keyCornerRadius))
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                keyIcon(key)
            }
            .onTapGesture {
                onKeyPress(key)
            }
            .animation(Styles.animation, value: status)
    }
    
    @ViewBuilder
    func keyIcon(_ key: String) -> some View {
        switch key {
        case "DELETE":
            Image(systemName: "delete.left")
        case "ENTER":
            Image(systemName: "return")
        case "RESET":
            Image(systemName: "arrow.clockwise")
        default:
            Text(key)
        }
    }
}

#Preview {
    KeyView(key: "Q", onKeyPress: { key in print("Pressed", key) })
}

