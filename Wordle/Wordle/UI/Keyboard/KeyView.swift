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
    let status: Status = .blank
    
    var body: some View {
        keyIcon(key)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background {
                 Styles.statusToColor(status)
            }
            .clipShape(RoundedRectangle(cornerRadius: Styles.keyCornerRadius))
            .aspectRatio(1, contentMode: .fill)
            .onTapGesture {
                onKeyPress(key)
            }
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

