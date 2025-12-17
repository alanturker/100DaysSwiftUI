//
//  Enums.swift
//  iExpenseApp
//
//  Created by Turker Alan on 26.11.2025.
//

import Foundation

enum ExpenseFilter: String, CaseIterable, Identifiable {
    case all
    case personal
    case business
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .all: return "All"
        case .personal: return "Only Personal"
        case .business: return "Only Business"
        }
    }
}
