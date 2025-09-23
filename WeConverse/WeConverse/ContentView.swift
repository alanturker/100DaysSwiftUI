//
//  ContentView.swift
//  WeConverse
//
//  Created by Turker Alan on 23.09.2025.
//

import SwiftUI

struct ContentView: View {

    let units: [UnitLength] = [
        .meters,
        .kilometers,
        .feet,
        .yards,
        .miles
    ]

    func convert(_ value: Double, from: UnitLength, to: UnitLength) -> Double {
        let value = Measurement(value: value, unit: from)
        return value.converted(to: to).value
    }
    
    @State private var selectedUnitFrom: UnitLength = .meters
    @State private var selectedUnitTo: UnitLength = .meters
    @State private var amount: Double = 0.0
    @FocusState private var isAmountFocused: Bool
    
    private var newAmount: Double {
        convert(amount, from: selectedUnitFrom, to: selectedUnitTo)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Give a Number and Choose Unit") {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isAmountFocused)
                    
                    Picker("From", selection: $selectedUnitFrom) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    
                    Picker("To", selection: $selectedUnitTo) {
                        ForEach(units, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                }
                
                Section("To") {
                    Text(newAmount, format: .number)
                }
            }
            .navigationTitle("WeConverse")
            .toolbar {
                if isAmountFocused {
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
               
            }
        }
    }
}

#Preview {
    ContentView()
}
