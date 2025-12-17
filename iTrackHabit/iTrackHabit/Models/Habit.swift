//
//  Habit.swift
//  iTrackHabit
//
//  Created by Turker Alan on 19.11.2025.
//

import Foundation

struct Habit: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var title: String
    var description: String
    var count: Int
}
