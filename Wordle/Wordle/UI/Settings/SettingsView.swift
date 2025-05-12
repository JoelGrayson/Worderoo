//
//  SettingsView.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

struct SettingsView: View {
    // Passed in
    @Binding var configurableSettings: ConfigurableSettings

    // State owned by me
    @State private var showSettingsModal = false

    var body: some View {
        Button {
            showSettingsModal = true
        } label: {
            Image(systemName: "gearshape.fill")
        }
        .sheet(isPresented: $showSettingsModal) {
            Text("Settings")
            Form {
                Section {
                    Stepper("Words for new games will be \(configurableSettings.wordSizeForNewGames) letters long", value: $configurableSettings.wordSizeForNewGames)
                }
            }
        }
    }
}

#Preview {
    SettingsView(
        configurableSettings: .constant(ConfigurableSettings())
    )
}
