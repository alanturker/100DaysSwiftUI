//
//  ReturnToRootView.swift
//  Navigation
//
//  Created by Turker Alan on 19.11.2025.
//

import SwiftUI

struct DetailView: View {
    var number: Int
//    @Binding var path: [Int]
    @Binding var path: NavigationPath
    var body: some View {
        NavigationLink("Go to Random Number", value: Int.random(in: 1...1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button {
//                    path.removeAll()
                    path = NavigationPath()
                } label: {
                    Text("Home")
                }

            }
    }
}

struct ReturnToRootView: View {
//    @State private var path = [Int]()
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            DetailView(number: 0, path: $path)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i, path: $path)
                }
        }
    }
}

#Preview {
    ReturnToRootView()
}
