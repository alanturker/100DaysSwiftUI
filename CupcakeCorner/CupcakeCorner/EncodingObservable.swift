//
//  EncodingObservable.swift
//  CupcakeCorner
//
//  Created by Turker Alan on 24.11.2025.
//

import SwiftUI

@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }

    var name = "Taylor"
}

struct EncodingObservable: View {
    var body: some View {
           Button("Encode Taylor", action: encodeTaylor)
       }

       func encodeTaylor() {
           let data = try! JSONEncoder().encode(User())
           let str = String(decoding: data, as: UTF8.self)
           print(str)
       }
}

#Preview {
    EncodingObservable()
}
