//
//  UserFriendAppApp.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import SwiftUI
import SwiftData

@main
struct UserFriendAppApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
        .modelContainer(for: User.self)
    }
}
