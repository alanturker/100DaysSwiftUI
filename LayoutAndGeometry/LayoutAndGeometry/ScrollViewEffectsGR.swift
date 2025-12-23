//
//  ScrollViewEffectsGR.swift
//  LayoutAndGeometry
//
//  Created by Turker Alan on 21.12.2025.
//

import SwiftUI

struct ScrollViewEffectsGR: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        ScrollView {
            ForEach(0..<50) { index in
                GeometryReader { proxy in
                    let minY = proxy.frame(in: .global).minY
                    let opacity = max(0, min(1, (minY - 200) / 200))
                    let scale = max(0.5, min(1.2, minY / 600))
                    let hue = min(1.0, max(0.0, minY / 800))
                    
                    Text("Row #\(index)")
                        .font(.title)
                        .frame(maxWidth: .infinity)
//                        .background(colors[index % 7])
                        .background(
                            Color(hue: hue, saturation: 0.8, brightness: 0.95)
                        )
                        .rotation3DEffect(.degrees(proxy.frame(in: .global).minY / 5), axis: (x: 0, y: 1, z: 0))
                        .scaleEffect(scale, anchor: .center)
                        .opacity(opacity)

                }
                .frame(height: 40)
               
            }
        }
        
//        ScrollView(.horizontal, showsIndicators: false) {
//                   HStack(spacing: 0) {
//                       ForEach(1..<20) { num in
//                           GeometryReader { proxy in
//                               Text("Number \(num)")
//                                   .font(.largeTitle)
//                                   .padding()
//                                   .background(.red)
//                                   .rotation3DEffect(.degrees(-proxy.frame(in: .global).minX) / 8, axis: (x: 0, y: 1, z: 0))
//                                   .frame(width: 200, height: 200)
//                           }
//                           .frame(width: 200, height: 200)
//                       }
//                   }
//               }
    }
}

#Preview {
    ScrollViewEffectsGR()
}
