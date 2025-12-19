//
//  CustomRowSwipeExample.swift
//  HotProspects
//
//  Created by Turker Alan on 18.12.2025.
//

import SwiftUI

struct CustomRowSwipeExample: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Send message", systemImage: "message") {
                        print("Hi")
                    }
                }
        }
        
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Deleting")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
        }
    }
}

#Preview {
    CustomRowSwipeExample()
}
