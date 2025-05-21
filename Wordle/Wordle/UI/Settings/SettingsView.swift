//
//  SettingsView.swift
//  Wordle
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI
import SwiftData

let wordSizeForNewGamesBounds = 3...6
let numGuessesAllowedBounds = 3...10

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var configurableSettings: [ConfigurableSettings]

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
            
//            Form {
//                Section {
//                    // Received inspiration from https://stackoverflow.com/questions/71241005/swiftui-form-number-input
//                    // Read docs for onIncrement and onDecrement at https://developer.apple.com/documentation/swiftui/stepper
//                    Stepper(
//                        "Words for new games will be \(configurableSettings.wordSizeForNewGames) letters long",
//                        onIncrement: {
//                            if configurableSettings.wordSizeForNewGames < wordSizeForNewGamesBounds.upperBound {
//                                // Update game
//                                updateSettings { settings in
//                                    settings.wordSizeForNewGames += 1
//                                }
//                            }
//                        },
//                        onDecrement: {
//                            if configurableSettings.wordSizeForNewGames > wordSizeForNewGamesBounds.lowerBound {
//                                configurableSettings.wordSizeForNewGames -= 1
//                            }
//                        }
//                    )
//                }
//                
////                Section {
////                    // Received inspiration from https://stackoverflow.com/questions/71241005/swiftui-form-number-input
////                    // Read docs for onIncrement and onDecrement at https://developer.apple.com/documentation/swiftui/stepper
////                    Stepper(
////                        "Number of guesses allowed: \(configurableSettings.numGuessesAllowed)",
////                        onIncrement: {
////                            //AI fixed a syntax bug here
////                            if configurableSettings.numGuessesAllowed < numGuessesAllowedBounds.upperBound {
////                                configurableSettings.numGuessesAllowed += 1
////                            }
////                        },
////                        onDecrement: {
////                            if configurableSettings.numGuessesAllowed > numGuessesAllowedBounds.lowerBound {
////                                configurableSettings.numGuessesAllowed -= 1
////                            }
////                        }
////                    )
////                }
////                
////                Section {
////                    Toggle("Only allow guesses that are English words", isOn: $configurableSettings.checkIfEnglishWord)
////                }
//            }
        }
    }
    
    func updateSettings(_ callback: (inout ConfigurableSettings) -> Void) {
        var newSettings = ConfigurableSettings(configurableSettings[0])
        callback(&newSettings)
        modelContext.delete(configurableSettings[0])
        modelContext.insert(newSettings)
    }
}

//#Preview {
//    SettingsView(
//        configurableSettings: .constant(ConfigurableSettings())
//    )
//}
