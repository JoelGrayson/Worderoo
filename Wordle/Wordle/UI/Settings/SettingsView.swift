//
//  SettingsView.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI

let wordSizeForNewGamesBounds = 3...6
let numGuessesAllowedBounds = 3...10

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
                .font(.title)
                .padding()
            
            Form {
                Section {
                    // Received inspiration from https://stackoverflow.com/questions/71241005/swiftui-form-number-input
                    // Read docs for onIncrement and onDecrement at https://developer.apple.com/documentation/swiftui/stepper
                    Stepper(
                        "Words for new games will be \(configurableSettings.wordSizeForNewGames) letters long",
                        onIncrement: {
                            if configurableSettings.wordSizeForNewGames < wordSizeForNewGamesBounds.upperBound {
                                configurableSettings.wordSizeForNewGames += 1
                            }
                        },
                        onDecrement: {
                            if configurableSettings.wordSizeForNewGames > wordSizeForNewGamesBounds.lowerBound {
                                configurableSettings.wordSizeForNewGames -= 1
                            }
                        }
                    )
                }
                
                Section {
                    // Received inspiration from https://stackoverflow.com/questions/71241005/swiftui-form-number-input
                    // Read docs for onIncrement and onDecrement at https://developer.apple.com/documentation/swiftui/stepper
                    Stepper(
                        "Number of guesses allowed: \(configurableSettings.numGuessesAllowed)",
                        onIncrement: {
                            //AI fixed a syntax bug here
                            if configurableSettings.numGuessesAllowed < numGuessesAllowedBounds.upperBound {
                                configurableSettings.numGuessesAllowed += 1
                            }
                        },
                        onDecrement: {
                            if configurableSettings.numGuessesAllowed > numGuessesAllowedBounds.lowerBound {
                                configurableSettings.numGuessesAllowed -= 1
                            }
                        }
                    )
                }
                
                Section {
                    Toggle("Only allow guesses that are English words", isOn: $configurableSettings.checkIfEnglishWord)
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
