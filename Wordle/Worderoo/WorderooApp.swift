//
//  WorderooApp.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI
import SwiftData

@main
struct WorderooApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ConfigurableSettings.self, Game.self])
        }
        
        #if os(macOS) || os(iOS)
        Settings {
            SettingsButtonThatOpensModal()
        }
        #endif
    }
}
