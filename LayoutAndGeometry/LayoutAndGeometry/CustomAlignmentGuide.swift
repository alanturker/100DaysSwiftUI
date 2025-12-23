//
//  CustomAlignmentGuide.swift
//  LayoutAndGeometry
//
//  Created by Turker Alan on 21.12.2025.
//

import SwiftUI

struct CustomAlignmentGuide: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@twostraws")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                Image(.paulHudson)
                    .resizable()
                    .frame(width: 64, height: 64)
            }

            VStack {
                Text("Full name:")
                Text("PAUL HUDSON")
                    .alignmentGuide(.midAccountAndName) { d in d[VerticalAlignment.center] }
                    .font(.largeTitle)
            }
        }
        
        Text("Hello, world!")
            .background(.red)
            .position(x: 100, y: 100)
        
        Text("Hello, world!")
            .position(x: 100, y: 100)
            .background(.red)
        
        Text("Hello, world!")
               .offset(x: 100, y: 100)
               .background(.red)
    }
}

#Preview {
    CustomAlignmentGuide()
}

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}
