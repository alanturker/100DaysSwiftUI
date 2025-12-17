//
//  NavigationTitleEdit.swift
//  Navigation
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI

struct NavigationTitleEdit: View {
    @State private var title = "SwiftUI"
    
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
                .navigationTitle($title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NavigationTitleEdit()
}
