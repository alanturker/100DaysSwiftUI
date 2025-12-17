//
//  HomeViewModel.swift
//  iTrackHabit
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI
import Combine

final class HomeViewModel: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet {
            if let encodedValue = try? JSONEncoder().encode(habits) {
                saveHabits(data: encodedValue)
            }
        }
    }
    
    init() {
        if let savedHabitData = UserDefaults.standard.data(forKey: "habits"),
           let savedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabitData) {
            habits = savedHabits
            return
        }
        
        habits = []
    }
    
    private func saveHabits(data: Data) {
        UserDefaults.standard.set(data, forKey: "habits")
    }
    
    func removeHabit(atOffsets offsets: IndexSet) {
        habits.remove(atOffsets: offsets)
    }
    
    func handletHabitCount(_ habit: Habit, count: Int) {
        guard let index = habits.firstIndex(of: habit) else { return }
        var newHabit = habit
        newHabit.count = count
        habits[index] = newHabit
    }
}
