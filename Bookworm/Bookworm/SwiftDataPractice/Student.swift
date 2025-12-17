//
//  Student.swift
//  Bookworm
//
//  Created by Turker Alan on 25.11.2025.
//

import SwiftUI
import SwiftData

@Model
class Student {
    var id: UUID
    var name: String

    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
