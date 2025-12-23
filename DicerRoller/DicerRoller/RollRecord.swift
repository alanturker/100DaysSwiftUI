//
//  RoleRecord.swift
//  DicerRoller
//
//  Created by Turker Alan on 22.12.2025.
//

import SwiftUI

struct RollRecord: Identifiable, Codable, Equatable {
    let id: UUID
    let date: Date
    let sides: Int
    let count: Int
    let results: [Int]

    var total: Int { results.reduce(0, +) }

    init(id: UUID = UUID(), date: Date = Date(), sides: Int, count: Int, results: [Int]) {
        self.id = id
        self.date = date
        self.sides = sides
        self.count = count
        self.results = results
    }
}
