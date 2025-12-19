//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Turker Alan on 18.12.2025.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
