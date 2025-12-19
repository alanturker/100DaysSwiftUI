//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Turker Alan on 18.12.2025.
//

import SwiftUI

struct EditProspectView: View {
    @Environment(\.dismiss) var dismiss
    let prospect: Prospect
    @State private var name = ""
    @State private var emailAddress = ""
    @State private var isContacted = false
    
    var onUpdate: (Prospect) -> Void
    
    init(prospect: Prospect, onUpdate: @escaping (Prospect) -> Void) {
        self.prospect = prospect
        self.onUpdate = onUpdate
        _name = State(initialValue: prospect.name)
        _emailAddress = State(initialValue: prospect.emailAddress)
        _isContacted = State(initialValue: prospect.isContacted)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                Button("Update") {
                    let prospect = Prospect(name: name, emailAddress: emailAddress, isContacted: isContacted)
                    onUpdate(prospect)
                    dismiss()
                }
            }
            .navigationTitle("Edit Prospect")
        }
    }
}

#Preview {
    EditProspectView(prospect: Prospect(name: "", emailAddress: "", isContacted: false)) { _ in }
}
