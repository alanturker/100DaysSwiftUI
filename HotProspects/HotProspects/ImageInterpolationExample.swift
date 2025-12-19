//
//  ImageInterpolationExample.swift
//  HotProspects
//
//  Created by Turker Alan on 18.12.2025.
//

import SwiftUI

struct ImageInterpolationExample: View {
    var body: some View {
        Image(.example)
            .interpolation(.none) 
            .resizable()
            .scaledToFit()
            .background(.black)
    }
}

#Preview {
    ImageInterpolationExample()
}
