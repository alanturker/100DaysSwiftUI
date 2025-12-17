//
//  DetailView.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Query private var users: [User]
    let user: User
    
    var body: some View {
        ScrollView {
            Section("About") {
                Text(user.about)
            }
            .padding()
            
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(user.friends) { friend in
                        NavigationLink(value: friend) {
                            Text(friend.name)
                                .fontWeight(.bold)
                                .padding(10)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.red)
                                )
                        }
                    }
                }
                .padding()
            }
        }
        .navigationTitle(user.name)
        .navigationDestination(for: Friend.self) { friend in
            if let user = users.first(where: { $0.id == friend.id }) {
                DetailView(user: user)
            }
        }
    }
}
