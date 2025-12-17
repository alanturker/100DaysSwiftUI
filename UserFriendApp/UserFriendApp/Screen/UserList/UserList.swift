//
//  UserList.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import SwiftUI
import SwiftData

struct UserList: View {
    @Query private var users: [User]
    
    init(filter: UserFilter, sortOrder: [SortDescriptor<User>]) {
        switch filter {
        case .all:
            _users = Query(sort: sortOrder)
        case .active:
            _users = Query(
                filter: #Predicate<User> { user in
                    user.isActive
                }, sort: sortOrder)
        case .inactive:
            _users = Query(
                filter: #Predicate<User> { user in
                    !user.isActive
                }, sort: sortOrder)
        }
    }
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            Text(user.name)
                            Text(String(user.age))
                            Spacer()
                            Text(user.registeredFormatted)
                            Image(systemName: "smallcircle.filled.circle.fill")
                                .foregroundStyle(user.isActive ? .green : .red)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    }
                }
            }
        }
    }
}

#Preview {
    UserList(filter: .all, sortOrder: [SortDescriptor(\User.name)])
}
