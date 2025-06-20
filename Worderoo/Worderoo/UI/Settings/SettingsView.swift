//
//  SettingsView.swift
//  Worderoo
//
//  Created by Joel Grayson on 6/15/25.
//

import SwiftUI
import SwiftData

let wordSizeForNewGamesBounds = 3...6
let numGuessesAllowedBounds = 3...9 //10 looks weird

struct SettingsView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var rawSettings: [ConfigurableSettings]
    var configurableSettings: ConfigurableSettings { rawSettings.first ?? defaultConfigurableSettings }
    var close: (() -> Void)? //if defined, then this can be closed (such as by opening it from a modal) by calling this function. Otherwise, it cannot be closed with the button, such as on mac when opened from the settings ⌘, shortcut
    
    
    var body: some View {
        Text("Settings")
            .font(.title)
            .padding(.top, Styles.sheetTitlePadding)
            .bold()
            .frame(maxWidth: .infinity)
            .overlay(alignment: .trailing) {
                if let close {
                    Button {
                        close()
                    } label: {
                        CloseIcon()
                    }
                    .padding([.top, .trailing], Styles.closeIconPadding)
                }
            }
        
        Form {
            Section {
                // Received inspiration from https://stackoverflow.com/questions/71241005/swiftui-form-number-input
                // Read docs for onIncrement and onDecrement at https://developer.apple.com/documentation/swiftui/stepper
                Stepper(
                    "Words for new games will be \(configurableSettings.wordSizeForNewGames) letters long",
                    onIncrement: {
                        if configurableSettings.wordSizeForNewGames < wordSizeForNewGamesBounds.upperBound {
                            // Update game
                            updateSettings { settings in
                                settings.wordSizeForNewGames += 1
                            }
                        }
                    },
                    onDecrement: {
                        if configurableSettings.wordSizeForNewGames > wordSizeForNewGamesBounds.lowerBound {
                            updateSettings { $0.wordSizeForNewGames -= 1 }
                        }
                    }
                )
                
                
                // Received inspiration from https://stackoverflow.com/questions/71241005/swiftui-form-number-input
                // Read docs for onIncrement and onDecrement at https://developer.apple.com/documentation/swiftui/stepper
                Stepper(
                    "Number of guesses allowed: \(configurableSettings.numGuessesAllowed)",
                    onIncrement: {
                        //AI fixed a syntax bug here
                        if configurableSettings.numGuessesAllowed < numGuessesAllowedBounds.upperBound {
//                                configurableSettings.numGuessesAllowed += 1
                            updateSettings { $0.numGuessesAllowed += 1 }
                        }
                    },
                    onDecrement: {
                        if configurableSettings.numGuessesAllowed > numGuessesAllowedBounds.lowerBound {
//                                configurableSettings.numGuessesAllowed -= 1
                            updateSettings { $0.numGuessesAllowed -= 1 }
                        }
                    }
                )

                Toggle("Only allow guesses that are English words", isOn: Binding<Bool>(
                    get: {
                        configurableSettings.checkIfEnglishWord
                    },
                    set: { newValue in
                        updateSettings {
                            $0.checkIfEnglishWord = newValue
                        }
                    }
                ))
                
                Toggle("Only show games that are incomplete", isOn: Binding<Bool>(
                    get: {
                        configurableSettings.onlyShowIncompleteGames
                    },
                    set: { newValue in
                        updateSettings {
                            $0.onlyShowIncompleteGames = newValue
                        }
                    }
                ))
                
                Toggle("Haptic feedback (keys vibrate)", isOn: Binding<Bool>(
                    get: {
                        configurableSettings.hapticFeedback
                    },
                    set: { newValue in
                        updateSettings {
                            $0.hapticFeedback = newValue
                        }
                    }
                ))
            }
            
            Section {
                if let url = URL(string: "https://forms.gle/2M3f8x14xyb1ctED6") {
                    Link(destination: url) {
                        Text("Leave feedback or report a bug")
                    }
                } else {
                    Text("If you have any feedback or there is a bug, feel free to email joel@joelgrayson.com")
                }
            }
        }
        
        Button("Reset Settings", systemImage: "arrow.counterclockwise.circle") {
            updateSettings { $0 = defaultConfigurableSettings }
        }
        .tint(.red)
        .padding(.vertical)
        .padding(.top)
    }
    
    func updateSettings(_ callback: (inout ConfigurableSettings) -> Void) {
        var newSettings = ConfigurableSettings(configurableSettings)
        callback(&newSettings)
        modelContext.delete(configurableSettings)
        modelContext.insert(newSettings)
    }
}

