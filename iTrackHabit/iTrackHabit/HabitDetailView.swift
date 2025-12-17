//
//  HabitDetailView.swift
//  iTrackHabit
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI

struct HabitDetailView: View {
    var habit: Habit
    @ObservedObject var viewModel: HomeViewModel
    @State private var count: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
           
            Text("Description")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Text("\(habit.description)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            Text("Count")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
            Text("\(count)")
                .font(.callout)
                .foregroundStyle(.secondary)
            
            HStack(spacing: 20) {
                Button {
                    if count > 0 {
                        count -= 1
                    }
                } label: {
                    Image(systemName: "minus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
                
                Button {
                    count += 1
                } label: {
                    Image(systemName: "plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            
            Spacer()
        }
        .onAppear {
            count = habit.count
        }
        .onDisappear(perform: {
            viewModel.handletHabitCount(habit, count: count)
        })
        .navigationTitle("\(habit.title)")
    }
}

#Preview {
    HabitDetailView(habit: Habit(title: "", description: "", count: 0), viewModel: HomeViewModel())
}
