//
//  SettingsButtonThatOpensModal.swift
//  Worderoo
//
//  Created by Joel Grayson on 5/12/25.
//

import SwiftUI
import SwiftData

struct SettingsButtonThatOpensModal: View {
    // State owned by me
    @State private var showSettingsModal = false

    var body: some View {
        Button {
            showSettingsModal = true
        } label: {
            Image(systemName: "gearshape.fill")
        }
        .sheet(isPresented: $showSettingsModal) {
            SettingsView(
                close: {
                    showSettingsModal = false
                }
            )
        }
    }
}

