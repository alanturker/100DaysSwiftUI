//
//  ExpenseItem.swift
//  iExpenseApp
//
//  Created by Turker Alan on 12.11.2025.
//

import SwiftUI
import SwiftData

@Model
class ExpenseItem {
    var id = UUID()
    var name: String
    var type: String
    var amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
