//
//  TransitionAnimation.swift
//  AnimationsApp
//
//  Created by Turker Alan on 11.11.2025.
//

import SwiftUI

struct TransitionAnimation: View {
    @State private var isShowingRed = false
    
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .slide))
            }
        }
    }
}

#Preview {
    TransitionAnimation()
}
