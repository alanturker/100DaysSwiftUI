//
//  ShareLinkExample.swift
//  Instafilter
//
//  Created by Turker Alan on 4.12.2025.
//

import SwiftUI

struct ShareLinkExample: View {
    var body: some View {
        let example = Image(systemName: "photo")

        ShareLink(item: example, preview: SharePreview("Singapore Airport", image: example)) {
            Label("Click to share", systemImage: "airplane")
        }
    }
}

#Preview {
    ShareLinkExample()
}
