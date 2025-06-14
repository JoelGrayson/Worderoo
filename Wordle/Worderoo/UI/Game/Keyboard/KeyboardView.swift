//
//  KeyboardView.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct KeyboardView: View {
    let onKeyPress: (_ key: String) -> Void
    let getKeyStatus: (_ key: String) -> Status //used for coloring the keys
    
    static let keys=[
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L", "ENTER"],
        ["RESET", "Z", "X", "C", "V", "B", "N", "M", "DELETE"]
    ]
    
    var body: some View {
        VStack(spacing: Styles.keySeparation) {
            ForEach(KeyboardView.keys, id: \.self) { keyRow in
                HStack(spacing: Styles.keySeparation) {
                    ForEach(keyRow, id: \.self) { key in
                        KeyView(key: key, onKeyPress: onKeyPress, status: getKeyStatus(key))
                    }
                }
                .padding(.horizontal, keyRow == KeyboardView.keys.last ? 14 : 0)
            }
        }
        .frame(maxWidth: 550)
        .padding()
    }
}

#Preview {
    KeyboardView(
        onKeyPress: { key in
            print("Pressed", key)
        },
        getKeyStatus: { key in Status.blank }
   )
}

