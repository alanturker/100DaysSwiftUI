//
//  HidingGroupingAccesibiltyExample.swift
//  AccessibilitySandbox
//
//  Created by Turker Alan on 16.12.2025.
//

import SwiftUI

struct HidingGroupingAccesibiltyExample: View {
    
    var body: some View {
        VStack {
            Image(.character)
                .accessibilityHidden(true)
            
            VStack {
                Text("Your score is")
                Text("1000")
                    .font(.title)
            }
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Your score is 1000")
        }
       
    }
}

#Preview {
    HidingGroupingAccesibiltyExample()
}
