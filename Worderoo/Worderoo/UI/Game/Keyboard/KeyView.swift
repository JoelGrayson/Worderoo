//
//  KeyView.swift
//  Worderoo
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
            .frame(minHeight: Styles.keyHeight, alignment: .center)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                keyIcon(key, color: Styles.statusToTextColor(status))
            }
            .onTapGesture {
                onKeyPress(key)
            }
            .animation(Styles.animation, value: status)
    }
    
    @ViewBuilder
    func keyIcon(_ key: String, color: Color) -> some View {
        Group {
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
        .foregroundStyle(color)
    }
}

#Preview {
    KeyView(key: "Q", onKeyPress: { key in print("Pressed", key) })
}

