//
//  AsyncImageUrlExample.swift
//  CupcakeCorner
//
//  Created by Turker Alan on 24.11.2025.
//

import SwiftUI

struct AsyncImageUrlExample: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

#Preview {
    AsyncImageUrlExample()
}
