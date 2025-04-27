//
//  CodesView.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

struct CodesView: View {
    @Binding var game: Game
    
    var body: some View {
        Text("Codes View")
        Text(game.masterWord)
    }
}

