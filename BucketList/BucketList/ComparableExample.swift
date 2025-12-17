//
//  ContentView.swift
//  BucketList
//
//  Created by Turker Alan on 9.12.2025.
//

import SwiftUI

struct UserComparable: Identifiable, Comparable {
    let id = UUID()
    var firstName: String
    var lastName: String
    
    static func <(lhs: UserComparable, rhs: UserComparable) -> Bool {
        lhs.lastName < rhs.lastName
    }
}


struct ComparableExample: View {
    let users = [
        UserComparable(firstName: "Arnold", lastName: "Rimmer"),
        UserComparable(firstName: "Kristine", lastName: "Kochanski"),
        UserComparable(firstName: "David", lastName: "Lister"),
      ].sorted()

      var body: some View {
          List(users) { user in
              Text("\(user.lastName), \(user.firstName)")
          }
      }
}

#Preview {
    ComparableExample()
}
