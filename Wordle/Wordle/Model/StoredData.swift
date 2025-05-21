//
//  StoredData.swift
//  Wordle
//
//  Created by Joel Grayson on 5/21/25.
//

import Foundation
import SwiftData

@Model
class StoredData {
    var games: [Game]
    var configuredSettings: ConfigurableSettings
    
    init(games: [Game] = [], configuredSettings: ConfigurableSettings = ConfigurableSettings()) {
        self.games = games
        self.configuredSettings = configuredSettings
    }
}

