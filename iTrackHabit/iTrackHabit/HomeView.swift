//
//  ContentView.swift
//  iTrackHabit
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    AddHabitView(viewModel: viewModel)
                } label: {
                    Text("Add Habit")
                }

                Section("Habits") {
                    ForEach(viewModel.habits) { habit in
                        
                        NavigationLink(value: habit) {
                            habitListItems(habit)
                        }
                    }
                    .onDelete { offSets in
                        viewModel.removeHabit(atOffsets: offSets)
                    }
                }
            }
            .navigationTitle("Habits Home View")
            .toolbar {
                EditButton()
            }
            .navigationDestination(for: Habit.self) { selectedHabit in
                HabitDetailView(habit: selectedHabit, viewModel: viewModel)
            }
        }
    }
    
    private func habitListItems(_ habit: Habit) -> some View {
        HStack {
            Text("\(habit.title)")
                .font(.title2)
                .foregroundStyle(.primary)
            Spacer()
            Text("Copmletion: \(habit.count)")
                .foregroundStyle(.secondary)
                .font(.caption)
        }
    }
}

#Preview {
    HomeView()
}
