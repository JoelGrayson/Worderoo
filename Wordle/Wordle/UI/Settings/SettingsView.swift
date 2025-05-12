//
//  SettingsView.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct SettingsView: View {
    @State private var showSettingsModal = false
    
    var body: some View {
        Button {
            showSettingsModal = true
        } label: {
            Image(systemName: "gearshape.fill")
        }
        .sheet(isPresented: $showSettingsModal) {
            Text("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
