//
//  Book.swift
//  Bookworm
//
//  Created by Turker Alan on 25.11.2025.
//

import SwiftUI
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date = .now) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
    
    var isHighlighted: Bool {
        rating == 1
    }
}
