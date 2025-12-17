//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Turker Alan on 26.11.2025.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView2()
        }
        .modelContainer(for: User.self)
    }
}
