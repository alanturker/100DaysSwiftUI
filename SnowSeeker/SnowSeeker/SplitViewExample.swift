//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Turker Alan on 22.12.2025.
//

import SwiftUI

struct SplitViewExample: View {
    var body: some View {
        NavigationSplitView(/*columnVisibility: .constant(.all)*/
            preferredCompactColumn: .constant(.detail)) {
            NavigationLink("Primary") {
                Text("New view")
            }
        } detail: {
            Text("Content")
                .navigationTitle("Content View")
        }
        .navigationSplitViewStyle(.balanced)
    }
}

#Preview {
    SplitViewExample()
}
