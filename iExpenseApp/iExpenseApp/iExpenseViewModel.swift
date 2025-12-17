//
//  iExpenseViewModel.swift
//  iExpenseApp
//
//  Created by Turker Alan on 12.11.2025.
//

import SwiftUI

//@Observable
//class ExpensesViewModel{
//    var items = [ExpenseItem]() {
//        didSet {
//            if let encoded = try? JSONEncoder().encode(items) {
//                UserDefaults.standard.set(encoded, forKey: "Items")
//            }
//        }
//    }
//    
//    init() {
//        if let savedItems = UserDefaults.standard.data(forKey: "Items"),
//           let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
//            items = decodedItems
//            return
//        }
//            
//        items = []
//    }
//}
