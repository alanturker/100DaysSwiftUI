//
//  AccesibilityNeedExample.swift
//  Flashzilla
//
//  Created by Turker Alan on 19.12.2025.
//

import SwiftUI

struct AccesibilityNeedExample: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    
    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundStyle(.white)
        .clipShape(.capsule)
    }
}

#Preview {
    AccesibilityNeedExample()
}
