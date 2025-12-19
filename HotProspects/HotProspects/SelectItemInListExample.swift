//
//  ContentView.swift
//  HotProspects
//
//  Created by Turker Alan on 18.12.2025.
//

import SwiftUI

struct SelectItemInListExample: View {
    @State private var selection = Set<String>()
    let users = ["Tohru", "Yuki", "Kyo", "Momiji"]
    
    var body: some View {
        List(users, id: \.self, selection: $selection) { user in
            Text(user)
        }
        
        if !selection.isEmpty {
            Text("You selected \(selection.formatted())")
        }
        
        EditButton()
    }
}

#Preview {
    SelectItemInListExample()
}
