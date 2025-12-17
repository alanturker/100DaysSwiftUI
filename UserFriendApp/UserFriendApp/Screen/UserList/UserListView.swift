//
//  ContentView.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import SwiftUI
import SwiftData

struct UserListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \User.name) private var users: [User]
    @State private var filterSelection: UserFilter = .all
    @State private var sortOrder = [
        SortDescriptor(\User.name),
        SortDescriptor(\User.age),
    ]
    
    var body: some View {
        NavigationStack {
            UserList(filter: filterSelection, sortOrder: sortOrder)
            .navigationTitle("Users")
            .navigationDestination(for: User.self, destination: { user in
                DetailView(user: user)
            })
            .task {
                await loadUsersIfNeeded()
            }
            .toolbar {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\User.name),
                                SortDescriptor(\User.age),
                            ])

                        Text("Sort by Age")
                            .tag([
                                SortDescriptor(\User.age),
                                SortDescriptor(\User.name)
                            ])
                    }
                }
                Menu("Filter", systemImage: "lineweight") {
                    Picker("Filter", selection: $filterSelection) {
                        ForEach(UserFilter.allCases) { filter in
                            Text(filter.title).tag(filter)
                        }
                    }
                }
            }
        }
    }
}

extension UserListView {
    @MainActor
    private func loadUsersIfNeeded() async {
        guard users.isEmpty else { return }
        await loadUsers()
    }
    
    @MainActor
    private func loadUsers() async {
        do {
            let remoteUsers = try await NetworkManager.shared.getUsers()
            
            for user in remoteUsers {
                modelContext.insert(user)
            }
            
        } catch {
            print("Error fetching users:", error)
        }
    }
}

#Preview {
    UserListView()
        .modelContainer(for: User.self, inMemory: true)
}

