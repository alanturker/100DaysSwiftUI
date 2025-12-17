//
//  NavBarAppearance.swift
//  Navigation
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI

struct NavBarAppearance: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { i in
                Text("Row \(i)")
            }
            .navigationTitle("Title goes here")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(.blue)
            .toolbarColorScheme(.dark)
//            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

#Preview {
    NavBarAppearance()
}
