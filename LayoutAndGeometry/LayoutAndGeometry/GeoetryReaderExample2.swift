//
//  GeoetryReaderExample2.swift
//  LayoutAndGeometry
//
//  Created by Turker Alan on 21.12.2025.
//

import SwiftUI

struct GeoetryReaderExample2: View {
    var body: some View {
//        VStack {
//            GeometryReader { proxy in
//                Text("Hello, World!")
//                    .frame(width: proxy.size.width * 0.9, height: 40)
//                    .background(.red)
//            }
//            .background(.green)
//            
//            Text("More text")
//                .background(.blue)
//        }
        
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

#Preview {
    GeoetryReaderExample2()
}

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            InnerView()
                .background(.green)
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            GeometryReader { proxy in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center: \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY)")
                        print("Custom center: \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY)")
                        print("Local center: \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY)")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}
