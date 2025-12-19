//
//  ReduceMotionExample.swift
//  Flashzilla
//
//  Created by Turker Alan on 19.12.2025.
//

import SwiftUI

struct ReduceMotionExample: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0
    
    var body: some View {
        Button("Hello, World!") {
            if reduceMotion {
                scale *= 1.5
            } else {
                withAnimation {
                    scale *= 1.5
                }
            }
            
        }
        .scaleEffect(scale)
        
        
        Button("Hello, World!") {
            withOptionalAnimation {
                scale *= 1.5
            }
            
        }
        .scaleEffect(scale)
    }
    
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

#Preview {
    ReduceMotionExample()
}
