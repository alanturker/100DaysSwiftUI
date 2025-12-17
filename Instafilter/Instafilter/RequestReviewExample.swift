//
//  RequestReviewExample.swift
//  Instafilter
//
//  Created by Turker Alan on 4.12.2025.
//

import SwiftUI
import StoreKit


struct RequestReviewExample: View {
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        Button("Leave a review") {
            requestReview()
        }
    }
}

#Preview {
    RequestReviewExample()
}
