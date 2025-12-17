//
//  PathStore.swift
//  Navigation
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI
import Combine

class PathStore: ObservableObject {
    @Published var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        // Still here? Start with an empty path.
        path = NavigationPath()
    }
    
    func save() {
        guard let represantation = path.codable else { return }
        do {
            let data = try JSONEncoder().encode(represantation)
            try data.write(to: savePath)
        } catch {
            print("Failed to save navigation data")
        }
    }
}

struct DetailView2: View {
    var number: Int

    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView: View {
    @State private var pathStore = PathStore()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
            DetailView2(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView2(number: i)
                }
        }
    }
}

#Preview {
    ContentView()
}
