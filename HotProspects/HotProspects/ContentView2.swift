//
//  ContentView.swift
//  HotProspects
//
//  Created by Turker Alan on 18.12.2025.
//

import SwiftUI
import SamplePackage

struct ContentView2: View {
    let possibleNumbers = 1...60
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        
        return strings.formatted()
    }
    
    var body: some View {
        Text(results)
    }
}

#Preview {
    ContentView()
}
