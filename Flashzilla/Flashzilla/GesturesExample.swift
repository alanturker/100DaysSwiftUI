//
//  ContentView.swift
//  Flashzilla
//
//  Created by Turker Alan on 19.12.2025.
//

import SwiftUI

struct GesturesExample: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    @State private var currentAmountRotate = Angle.zero
    @State private var finalAmountRotate = Angle.zero
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    var body: some View {
        VStack(spacing: 200) {
            Text("Magnifying Gesture")
                .scaleEffect(finalAmount + currentAmount)
                .gesture(
                    MagnifyGesture()
                        .onChanged { value in
                            currentAmount = value.magnification - 1
                        }
                        .onEnded { value in
                            finalAmount += currentAmount
                            currentAmount = 0
                        }
                )
            
            
            Text("Ratation Gesture")
                .rotationEffect(currentAmountRotate + finalAmountRotate)
                .gesture(
                    RotateGesture()
                        .onChanged { value in
                            currentAmountRotate = value.rotation
                        }
                        .onEnded { value in
                            finalAmountRotate += currentAmountRotate
                            currentAmountRotate = .zero
                        }
                )
            
            
            VStack {
                Text("Hello, World!")
                    .onTapGesture {
                        print("Text tapped")
                    }
            }
            .simultaneousGesture(
                TapGesture()
                    .onEnded {
                        print("VStack tapped")
                    }
            )
            
            let dragGesture = DragGesture()
                .onChanged { value in offset = value.translation }
                .onEnded { _ in
                    withAnimation {
                        offset = .zero
                        isDragging = false
                    }
                }
            
            // a long press gesture that enables isDragging
            let pressGesture = LongPressGesture()
                .onEnded { value in
                    withAnimation {
                        isDragging = true
                    }
                }
            
            // a combined gesture that forces the user to long press then drag
            let combined = pressGesture.sequenced(before: dragGesture)
            
            // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
            Circle()
                .fill(.red)
                .frame(width: 64, height: 64)
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(offset)
                .gesture(combined)
        }
        
    }
}

#Preview {
    GesturesExample()
}
