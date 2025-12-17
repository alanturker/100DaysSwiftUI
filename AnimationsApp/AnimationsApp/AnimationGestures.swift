//
//  AnimationGestures.swift
//  AnimationsApp
//
//  Created by Turker Alan on 11.11.2025.
//

import SwiftUI

struct AnimationGestures: View {
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                withAnimation(.bouncy) {
                                    dragAmount = .zero
                                }
                               }
                    )
//                    .animation(
//                        .bouncy,
//                        value: dragAmount
//                    )
    }
}

#Preview {
    AnimationGestures()
}
