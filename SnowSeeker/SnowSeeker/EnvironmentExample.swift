//
//  EnvironmentExample.swift
//  SnowSeeker
//
//  Created by Turker Alan on 23.12.2025.
//

import SwiftUI

struct EnvironmentExample: View {
    @State private var player = Player()
    
    var body: some View {
        VStack {
            Text("Welcome!")
            HighScoreView()
        }
        .environment(player)
    }
}

#Preview {
    EnvironmentExample()
}

@Observable
class Player {
    var name = "Anonymous"
    var highScore = 0
}

struct HighScoreView: View {
    @Environment(Player.self) var player

    var body: some View {
        @Bindable var player = player
        Stepper("High score: \(player.highScore)", value: $player.highScore)
    }
}
