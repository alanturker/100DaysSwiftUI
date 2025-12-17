//
//  iExpenseAppApp.swift
//  iExpenseApp
//
//  Created by Turker Alan on 12.11.2025.
//

import SwiftUI
import SwiftData

@main
struct iExpenseAppApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
