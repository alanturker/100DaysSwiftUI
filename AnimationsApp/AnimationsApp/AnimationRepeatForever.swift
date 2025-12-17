//
//  ContentView.swift
//  AnimationsApp
//
//  Created by Turker Alan on 11.11.2025.
//

import SwiftUI

struct AnimationRepeatForever: View {
    
    @State private var animationAmount = 1.0
    
    var body: some View {
        Button("Tap Me") {
//            animationAmount += 1
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
//        .scaleEffect(animationAmount)
//        .blur(radius: (animationAmount - 1) * 3)
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animationAmount)
                .opacity(2 - animationAmount)
                .animation(
                    .easeOut(duration: 1)
                    .repeatForever(autoreverses: false),
                           value: animationAmount)
        )
        .onAppear{
            animationAmount = 2
        }
       
    }
}

#Preview {
    AnimationRepeatForever()
}
