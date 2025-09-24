//
//  ContentView.swift
//  WeGuessTheFlag
//
//  Created by Turker Alan on 23.09.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries: [String] = ["Italy", "Estonia", "Germany", "France", "Ireland", "Spain", "UK", "Ukraine", "Poland", "Nigeria", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle: String = ""
    @State private var score: Int = 0
    
    @State private var showFinish = false
    @State private var numberOfQuestionsAnswered = 0
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
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
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
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
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong that is the flag of \(countries[number])"
            score -= 1
        }
        
        if numberOfQuestionsAnswered >= 8 {
            showFinish = true
        } else {
            showingScore = true
        }
        
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func restart() {
        score = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
