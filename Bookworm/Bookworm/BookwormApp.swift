//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Turker Alan on 25.11.2025.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Book.self)
        }
    }
}
