//
//  ContentView.swift
//  Bookworm
//
//  Created by Turker Alan on 25.11.2025.
//

import SwiftUI

struct BindingPractice: View {
    @State private var rememberMe = false

    var body: some View {
        VStack {
            PushButton(title: "Remember Me", isOn: $rememberMe)
            Text(rememberMe ? "On" : "Off")
        }
    }
}

#Preview {
    BindingPractice()
}
