//
//  Friend.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    var id: String
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
    }
    
    init(id: String,
         name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id          = try container.decode(String.self,  forKey: .id)
        name        = try container.decode(String.self,  forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id,    forKey: .id)
        try container.encode(name,  forKey: .name)
    }
}
