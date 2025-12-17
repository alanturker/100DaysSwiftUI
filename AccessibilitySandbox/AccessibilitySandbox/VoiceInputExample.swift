//
//  VoiceInputExample.swift
//  AccessibilitySandbox
//
//  Created by Turker Alan on 16.12.2025.
//

import SwiftUI

struct VoiceInputExample: View {
    var body: some View {
        Button("John Fitzgerald Kennedy") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["John Fitzgerald Kennedy", "Kennedy", "JFK"])
    }
}

#Preview {
    VoiceInputExample()
}
