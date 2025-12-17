//
//  NetworkManager.swift
//  UserFriendApp
//
//  Created by Turker Alan on 28.11.2025.
//

import Foundation

final class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    static let baseURL = "https://www.hackingwithswift.com/samples/friendface.json"
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: Self.baseURL) else {
            throw UserError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([User].self, from: data)
        } catch {
            throw UserError.parsingError
        }
    }
    
    enum UserError: Error {
        case invalidURL
        case parsingError
    }
}
