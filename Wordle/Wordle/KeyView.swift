//
//  KeyView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct KeyView: View {
    let key: String
    
    var body: some View {
        Text(key)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(.gray)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    KeyView(key: "Q")
}

