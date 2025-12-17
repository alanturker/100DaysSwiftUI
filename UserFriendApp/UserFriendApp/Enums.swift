//
//  Enums.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import Foundation

enum UserFilter: String, CaseIterable, Identifiable {
    case all
    case active
    case inactive
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .all: return "All"
        case .active: return "Active"
        case .inactive: return "Inactive"
        }
    }
}
