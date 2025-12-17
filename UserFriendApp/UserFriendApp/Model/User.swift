//
//  User.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import Foundation
import SwiftData

@Model
class User: Codable {
    struct TagValue: Codable {
        var value: String
    }
    
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [TagValue]
    @Relationship(deleteRule: .cascade) var friends: [Friend]

    enum CodingKeys: String, CodingKey {
        case id, isActive, name, age, company, email, address, about, registered, tags, friends
    }

    init(
        id: String,
        isActive: Bool,
        name: String,
        age: Int,
        company: String,
        email: String,
        address: String,
        about: String,
        registered: String,
        tags: [TagValue],
        friends: [Friend]
    ) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }

    // MARK: - Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id            = try container.decode(String.self,   forKey: .id)
        isActive      = try container.decode(Bool.self,     forKey: .isActive)
        name          = try container.decode(String.self,   forKey: .name)
        age           = try container.decode(Int.self,      forKey: .age)
        company       = try container.decode(String.self,   forKey: .company)
        email         = try container.decode(String.self,   forKey: .email)
        address       = try container.decode(String.self,   forKey: .address)
        about         = try container.decode(String.self,   forKey: .about)
        registered    = try container.decode(String.self,   forKey: .registered)
        friends       = try container.decode([Friend].self, forKey: .friends)
        
        let tagStrings = try container.decode([String].self, forKey: .tags)
        tags          = tagStrings.map { TagValue(value: $0) }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id,         forKey: .id)
        try container.encode(isActive,   forKey: .isActive)
        try container.encode(name,       forKey: .name)
        try container.encode(age,        forKey: .age)
        try container.encode(company,    forKey: .company)
        try container.encode(email,      forKey: .email)
        try container.encode(address,    forKey: .address)
        try container.encode(about,      forKey: .about)
        try container.encode(registered, forKey: .registered)
        let tagStrings = tags.map { $0.value }
        try container.encode(tagStrings, forKey: .tags)
        try container.encode(friends,    forKey: .friends)
    }
    
    var registeredDate: Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime]
        return formatter.date(from: registered)
    }

    var registeredFormatted: String {
        guard let date = registeredDate else { return registered }
        
        let out = DateFormatter()
        out.dateStyle = .medium     // "Nov 10, 2015"
        out.timeStyle = .short      // "1:47 AM"
        return out.string(from: date)
    }
}
