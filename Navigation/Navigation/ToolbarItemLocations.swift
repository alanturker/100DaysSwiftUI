//
//  ToolbarItemLocations.swift
//  Navigation
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI

struct ToolbarItemLocations: View {
    var body: some View {
        NavigationStack {
            Text("Hello, world!")
            .toolbar {
                ToolbarItem(placement: .navigation) {
                    Button("Tap Me") {
                        // button action here
                    }
                }
                /*
                 other placements:
                 -.confirmationAction
                 -.destructiveAction
                 -.cancellationAction
                 -.navigation
                 */
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                        Button("Tap Me2") {
                            // button action here
                        }

                        Button("Tap Me 3") {
                            // button action here
                        }
                    }
            }
        }
    }
}

#Preview {
    ToolbarItemLocations()
}
