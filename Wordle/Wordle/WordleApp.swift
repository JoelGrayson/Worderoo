//
//  WordleApp.swift
//  Wordle
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

@main
struct WordleApp: App {
    var body: some Scene {
        WindowGroup {
            WordleGamePicker()
                .modelContainer(for: [ConfigurableSettings.self, Game.self])
        }
    }
}
