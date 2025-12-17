//
//  ContentView.swift
//  WeGuessTheFlag
//
//  Created by Turker Alan on 23.09.2025.
//

import SwiftUI

struct LargeTitle: ViewModifier {
    var color: Color = .black
    
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundStyle(color)
    }
}

extension View {
    func largeTitle(color: Color = .black) -> some View {
        modifier(LargeTitle(color: color))
    }
}

struct ContentView: View {
    
    @State private var countries: [String] = ["Italy", "Estonia", "Germany", "France", "Ireland", "Spain", "UK", "Ukraine", "Poland", "Nigeria", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    
    @State private var showFinish = false
    @State private var numberOfQuestionsAnswered = 0
    @State private var flagBorderColor = Color.white
    @State private var isAnswered: Bool = false
    @State private var animationAmount = 0.0
    @State private var selectedNumber: Int? = nil
    
    @State private var rotationAmounts: [Double] = [0, 0, 0]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Text("Guess the Flag")
                    .largeTitle(color: .white)
                VStack {
                    Text("Tap the flag of:")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.bold))
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                            
                            withAnimation(.spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0)) {
                                rotationAmounts[number] += 360
                            }
                            
                        } label: {
                            FlagImage(number: number,
                                      countries: countries,
                                      color: getFlagBorderColor(forNumber: number))
                            .rotation3DEffect(.degrees(rotationAmounts[number]), axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity(forNumber: number))
                            .scaleEffect(scale(forNumber: number))
                            .animation(.easeInOut(duration: 0.35), value: selectedNumber)
                            .animation(.easeInOut(duration: 0.35), value: isAnswered)
                        }
                    }

                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 10))
                
                
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Finished the Game", isPresented: $showFinish) {
            Button("Restart", action: restart)
        } message: {
            Text("Your score is \(score). Game is finished.")
        }
       
    }
    
    private func flagTapped(_ number: Int) {
        numberOfQuestionsAnswered += 1
        isAnswered = true
        selectedNumber = number
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong that is the flag of \(countries[number])"
            score -= 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if score >= 10 {
                showFinish = true
            } else {
                showingScore = true
            }
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation {
            flagBorderColor = .white
            isAnswered = false
            selectedNumber = nil
        }
       
    }
    
    private func restart() {
        score = 0
        numberOfQuestionsAnswered = 0
        askQuestion()
    }
    
    private func getFlagBorderColor(forNumber number: Int) -> Color {
        if number == correctAnswer && isAnswered {
            return .green
        } else if number != correctAnswer && isAnswered {
            return .red
        } else {
            return .white
        }
    }
    
    private func opacity(forNumber number: Int) -> Double {
            guard isAnswered else { return 1 }
            if number == selectedNumber { return 1 }
            return 0.25
        }
        
        private func scale(forNumber number: Int) -> CGFloat {
            guard isAnswered else { return 1 }
            if number == selectedNumber { return 1 }
            return 0.9
        }
}

#Preview {
    ContentView()
}

struct FlagImage: View {
    var number: Int
    var countries: [String]
    var color: Color = .white
    
    var body: some View {
        Image(countries[number])
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20)
                .stroke(color.opacity(1.0), lineWidth: 4))
            .shadow(radius: 5)
    }
}
