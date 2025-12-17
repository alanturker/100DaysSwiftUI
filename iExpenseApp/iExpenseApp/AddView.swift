//
//  AddView.swift
//  iExpenseApp
//
//  Created by Turker Alan on 12.11.2025.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @State private var name = "Name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let types = ["Business", "Personal"]
    
    let userRegionCode = Locale.current.currency?.identifier ?? "USD"
    
    var body: some View {
        NavigationStack {
            Form {
//                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: userRegionCode))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                Button("Save") {
                    let expense = ExpenseItem(name: name, type: type, amount: amount)
                    modelContext.insert(expense)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddView()
}
