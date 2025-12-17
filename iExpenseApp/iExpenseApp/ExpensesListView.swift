//
//  ExpensesListView.swift
//  iExpenseApp
//
//  Created by Turker Alan on 26.11.2025.
//

import SwiftUI
import SwiftData

struct ExpensesListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [ExpenseItem]
    
    let userRegionCode: String
    
    init(filter: ExpenseFilter, userRegionCode: String, sortOrder: [SortDescriptor<ExpenseItem>]) {
        self.userRegionCode = userRegionCode

        
        switch filter {
        case .all:
            // Hiç filter vermiyoruz, tüm item’lar
            _items = Query(sort: sortOrder)
            
        case .personal:
            _items = Query(
                filter: #Predicate<ExpenseItem> { item in
                    item.type == "Personal"
                }, sort:  sortOrder
            )
            
        case .business:
            _items = Query(
                filter: #Predicate<ExpenseItem> { item in
                    item.type == "Business"
                }, sort: sortOrder
            )
        }
    }
    
    var body: some View {
        List {
            NavigationLink {
                AddView()
            } label: {
                Text("Add Expense")
            }
            
            ForEach(items) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: userRegionCode))
                        .amountStyle(amountDouble: item.amount)
                }
            }
            .onDelete(perform: removeItems)
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(items[index])
        }
    }
}


#Preview {
    ExpensesListView(filter: .all, userRegionCode: "USD", sortOrder: [SortDescriptor(\ExpenseItem.name)])
}
