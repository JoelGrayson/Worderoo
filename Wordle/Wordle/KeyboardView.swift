//
//  KeyboardView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct KeyboardView: View {
    let keys=[
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Delete", "Z", "X", "C", "V", "B", "N", "M", "Enter"]
    ]
    
    var body: some View {
        VStack {
            ForEach(keys, id: \.self) { keyRow in
                HStack {
                    ForEach(keyRow, id: \.self) { key in
                        KeyView(key: key)
                    }
                }
            }
        }
    }
}

#Preview {
    KeyboardView()
}
