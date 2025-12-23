//
//  GeometryReaderExample.swift
//  LayoutAndGeometry
//
//  Created by Turker Alan on 21.12.2025.
//

import SwiftUI

struct GeometryReaderExample: View {
    var body: some View {
//        VStack {
//            GeometryReader { proxy in
//                Image(.paulHudson)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: proxy.size.width * 0.8)
//            }
//            
//            
//            HStack {
//                Text("IMPORTANT")
//                    .frame(width: 200)
//                    .background(.blue)
//
//                Image(.paulHudson)
//                    .resizable()
//                    .scaledToFit()
//                    .containerRelativeFrame(.horizontal) { size, axis in
//                        size * 0.8
//                    }
//            }
//        }
        
        GeometryReader { proxy in
            Image(.paulHudson)
                .resizable()
                .scaledToFit()
                .frame(width: proxy.size.width * 0.8)
                .frame(width: proxy.size.width, height: proxy.size.height)
        }
       
    }
}

#Preview {
    GeometryReaderExample()
}
