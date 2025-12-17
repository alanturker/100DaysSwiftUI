//
//  TextEditorPractice.swift
//  Bookworm
//
//  Created by Turker Alan on 25.11.2025.
//

import SwiftUI

struct TextEditorPractice: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
            TextField("Enter your text", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
            
            TextEditor(text: $notes)
                .padding()
        }
    }
}

#Preview {
    TextEditorPractice()
}
