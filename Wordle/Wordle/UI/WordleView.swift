//
//  WordleView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct WordleView: View {
    var body: some View {
        VStack {
            CodesView() // a code is a single line (list of characters)
            KeyboardView()
        }
    }
}

#Preview {
    WordleView()
}
