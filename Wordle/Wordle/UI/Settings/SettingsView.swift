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
                    // Received inspiration from https://stackoverflow.com/questions/71241005/swiftui-form-number-input
                    // Read docs for onIncrement and onDecrement at https://developer.apple.com/documentation/swiftui/stepper
                    Stepper(
                        "Words for new games will be \(configurableSettings.wordSizeForNewGames) letters long",
                        onIncrement: {
                            if configurableSettings.wordSizeForNewGames < 6 {
                                configurableSettings.wordSizeForNewGames += 1
                            }
                        },
                        onDecrement: {
                            if configurableSettings.wordSizeForNewGames > 3 {
                                configurableSettings.wordSizeForNewGames -= 1
                            }
                        }
                    )
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
