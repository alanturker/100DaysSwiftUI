//
//  SearchableExample.swift
//  SnowSeeker
//
//  Created by Turker Alan on 23.12.2025.
//

import SwiftUI

struct SearchableExample: View {
    @State private var searchText = ""
        let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

        var filteredNames: [String] {
            if searchText.isEmpty {
                allNames
            } else {
                allNames.filter { $0.localizedStandardContains(searchText) }
            }
        }

        var body: some View {
            NavigationStack {
                List(filteredNames, id: \.self) { name in
                    Text(name)
                }
                .searchable(text: $searchText, prompt: "Look for something")
                .navigationTitle("Searching")
            }
        }
}

#Preview {
    SearchableExample()
}
