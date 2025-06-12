//
//  WorderooApp.swift
//  Worderoo
//
//  Created by Joel Grayson on 4/27/25.
//

import SwiftUI

@main
struct WorderooApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [ConfigurableSettings.self, Game.self])
        }
    }
}
