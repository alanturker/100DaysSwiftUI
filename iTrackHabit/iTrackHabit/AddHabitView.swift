//
//  AddHabitView.swift
//  iTrackHabit
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var viewModel: HomeViewModel
    @State private var name: String = "Add habit name"
    @State private var description: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            TextField("Add description", text: $description)
            
            Button("Add Habit", action: {
                let habit = Habit(title: name, description: description, count: 0)
                viewModel.habits.append(habit)
                dismiss()
            })
        }
        .navigationTitle($name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


