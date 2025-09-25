//
//  ContentView.swift
//  WeRockPaperScissors
//
//  Created by Turker Alan on 25.09.2025.
//

import SwiftUI

struct ContentView: View {
    
    enum Choice: String, CaseIterable, Identifiable {
        case rock, paper, scissors
        
        var id: String { self.rawValue }
        
        var emoji: String {
            switch self {
            case .rock:
                return "🪨"
            case .paper:
                return "📜"
            case .scissors:
                return "✂️"
            }
        }
    }
    
    enum GameResult {
        case win
        case lose
        case draw
    }
    
    @State private var choices: [Choice] = [.rock, .paper, .scissors].shuffled()
    @State private var swiftChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var playerChoice: Choice?
    @State private var score: Int = 0
    @State private var showAlert: Bool = false
    var body: some View {
        ZStack {
            LinearGradient(colors: [.brown, .gray.opacity(1), .red.opacity(0.6)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Section("You should:") {
                    Text(shouldWin ? "Win": "Lose")
                        .largeTitle(color: shouldWin ? .blue : .red)
                }
                .smallTitle(color: .white)
                
                Spacer()
                
                VStack {
                    ForEach(Choice.allCases, id: \.self) { choice in
                        Button {
                            select(choice)
                        } label: {
                            Text(choice.emoji)
                            Text(choice.id.capitalized)
                                .font(.system(size: 24))
                        }
                        .choiceStyle()
                    }
                    
                }
                Spacer()
                
                Text("Your Score: \(score)")
                
                Spacer()
            }
        }
        .alert("Your score is \(score)", isPresented: $showAlert) {
            Button("OK", action: nextRound)
        } message: {
            Text("You chose: \(playerChoice?.id ?? ""), swift chose: \(choices[swiftChoice].id)")
        }
    }
    
    private func nextRound() {
        shouldWin.toggle()
        swiftChoice = Int.random(in: 0...2)
        choices.shuffle()
    }
    
    private func select(_ choice: Choice) {
        playerChoice = choice
        switch gameResult(userChoice: choice, swiftChoice: choices[swiftChoice]) {
        case .win:
            score += shouldWin ? 1 : -1
        case .lose:
            score += shouldWin ? -1 : 1
        case .draw:
            break
        }
        
        DispatchQueue.main.async {
            showAlert = true
        }
    }
    
    private func gameResult(userChoice: Choice, swiftChoice: Choice) -> GameResult {
        if userChoice == swiftChoice {
            return .draw
        }
        
        switch userChoice {
        case .rock:
            return swiftChoice == .scissors ? .win : .lose
        case .paper:
            return swiftChoice == .rock ? .win : .lose
        case .scissors:
            return swiftChoice == .paper ? .win : .lose
        }
    }
}

#Preview {
    ContentView()
}

struct ChoiceStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding()
            .frame(width: 200)
            .background(.white.opacity(0.2))
            .clipShape(.capsule)
    }
}

struct LargeTitleStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 32, weight: .bold, design: .default))
            .foregroundStyle(color)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: 10))
    }
}

struct SmallTitleStyle: ViewModifier {
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .regular, design: .default))
            .foregroundStyle(color)
            .shadow(radius: 8)
    }
}

extension View {
    func largeTitle(color: Color = .red) -> some View {
        modifier(LargeTitleStyle(color: color))
    }
    
    func smallTitle(color: Color = .red) -> some View {
        modifier(SmallTitleStyle(color: color))
    }
    
    func choiceStyle() -> some View {
        modifier(ChoiceStyle())
    }
}
