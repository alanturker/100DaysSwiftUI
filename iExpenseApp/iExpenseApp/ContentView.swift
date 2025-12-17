//
//  ContentView.swift
//  iExpenseApp
//
//  Created by Turker Alan on 12.11.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var showingAddExpense = false
    @State private var filterSelection: ExpenseFilter = .all
    
    let userRegionCode = Locale.current.currency?.identifier ?? "USD"
    
    @State private var sortOrder = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount),
    ]
    
    var body: some View {
        NavigationStack {
            ExpensesListView(
                filter: filterSelection,
                userRegionCode: userRegionCode, sortOrder: sortOrder
            )
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
                
                Menu("Filter", systemImage: "lineweight") {
                    Picker("Filter", selection: $filterSelection) {
                        ForEach(ExpenseFilter.allCases) { filter in
                            Text(filter.title).tag(filter)
                        }
                    }
                }
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount),
                            ])

                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount),
                                SortDescriptor(\ExpenseItem.name)
                            ])
                    }
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView()
            }
        }
    }
}


#Preview {
    ContentView()
}


enum AmountSyle {
    case low, medium, large
}

struct AmountStyleModifier: ViewModifier {
    var amount: AmountSyle
    
    func body(content: Content) -> some View {
        switch amount {
        case .low:
            content
                .font(.title2.bold())
                .foregroundStyle(.green)
        case .medium:
            content
                .font(.title2.bold())
                .foregroundStyle(.orange)
        case .large:
            content
                .font(.title2.bold())
                .foregroundStyle(.red)
        }
        
    }
}

extension View {
    func amountStyle(amountDouble: Double) -> some View {
        var amount: AmountSyle = .medium
        if amountDouble < 10 {
            amount = .low
        } else if amountDouble < 50 {
            amount = .medium
        } else {
            amount = .large
        }
        return modifier(AmountStyleModifier(amount: amount))
    }
}
