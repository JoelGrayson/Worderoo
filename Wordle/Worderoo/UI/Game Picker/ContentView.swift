//
//  ContentView.swift
//  Worderoo
//
//  Created by Joel Grayson on 5/12/25.
//

// Includes Settings, filtering, and sorting options as well as the Game List

import SwiftUI
import SwiftData

struct ContentView: View {
    // Settings
    @Query private var rawSettings: [ConfigurableSettings]
    var configurableSettings: ConfigurableSettings { rawSettings.first ?? defaultConfigurableSettings }

    // Sorting and Filtering
    @State private var sortBy: SortOption = .newestFirst
    @State private var searchString = ""
    @State private var showTop = true
    
    var body: some View {
        //if designed for iPad running on mac, hide the top because it looks bad
        if showTop, UIDevice.current.userInterfaceIdiom == .phone { //not mac or iPad
            top
        }
        
        GameList(sortBy: sortBy, searchString: searchString, onlyShowIncompleteGames: configurableSettings.onlyShowIncompleteGames, showTop: $showTop)
            #if !os(macOS)
            .searchable(text: $searchString)
            #endif
            .animation(.easeInOut, value: searchString)
    }
    
    var top: some View {
        HStack(alignment: .center) {
            Text("Worderoo")
                .font(.title)
                .bold()
            
            Spacer()
            
            Picker("Sort By", selection: $sortBy.animation()) {
                ForEach(SortOption.allCases, id: \.self) { opt in
                    Text(opt.title)
                }
            }
            .pickerStyle(.menu)
            
            SettingsButtonThatOpensModal()
        }
        .padding()
        .padding(.horizontal)
    }
}

// Two sample games
var sampleGames = [
    Game(masterWord: "TREES", attempts: [ //in the middle
        Code(
            characters: [
                Character(value: "R", status: .wrongPlace),
                Character(value: "O", status: .notIn),
                Character(value: "U", status: .notIn),
                Character(value: "G", status: .notIn),
                Character(value: "H", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "T", status: .correct),
                Character(value: "A", status: .notIn),
                Character(value: "N", status: .notIn),
                Character(value: "G", status: .notIn),
                Character(value: "O", status: .notIn)
            ],
            kind: .attempt
        ),
    ]),
    Game(masterWord: "BASIN", attempts: [ //done
        Code(
            characters: [
                Character(value: "T", status: .notIn),
                Character(value: "E", status: .notIn),
                Character(value: "R", status: .notIn),
                Character(value: "R", status: .notIn),
                Character(value: "A", status: .wrongPlace)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "T", status: .notIn),
                Character(value: "R", status: .notIn),
                Character(value: "A", status: .wrongPlace),
                Character(value: "S", status: .wrongPlace),
                Character(value: "H", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "B", status: .correct),
                Character(value: "A", status: .correct),
                Character(value: "K", status: .notIn),
                Character(value: "E", status: .notIn),
                Character(value: "D", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "B", status: .correct),
                Character(value: "O", status: .notIn),
                Character(value: "A", status: .wrongPlace),
                Character(value: "R", status: .notIn),
                Character(value: "D", status: .notIn)
            ],
            kind: .attempt
        ),
        Code(
            characters: [
                Character(value: "B", status: .correct),
                Character(value: "A", status: .correct),
                Character(value: "S", status: .correct),
                Character(value: "I", status: .correct),
                Character(value: "N", status: .correct)
            ],
            kind: .attempt
        ),
    ], isOver: true),
    Game(masterWord: "WORLD"), //hasn't started
]

