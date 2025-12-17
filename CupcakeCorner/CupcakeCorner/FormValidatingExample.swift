//
//  FormValidatingExample.swift
//  CupcakeCorner
//
//  Created by Turker Alan on 24.11.2025.
//

import SwiftUI

struct FormValidatingExample: View {
    @State private var username = ""
    @State private var email = ""
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }
            
            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disableForm)
        }
    }
}

#Preview {
    FormValidatingExample()
}
