//
//  ContentView.swift
//  EdutainmentApp
//
//  Created by Turker Alan on 11.11.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var questionIndex: Int = 0
    @State private var upperBound: Int = 2
    
    @State private var questionBank: [Question] = []
    
    let questionNumberArray: [Int] = [5 , 10 ,15, 20]
    @State private var selectedQuestionNumber: Int = 5
    
    @State private var gameStarted: Bool = false
    
    @State private var textEntered: String = ""
    @State private var score: Int = 0
    @State private var showAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var alertType: AlertType = .correct
    
    @FocusState private var isFocused: Bool
    var body: some View {
        NavigationStack {
            VStack {
                if gameStarted {
                    Form {
                        Text("\(questionIndex + 1)) \(questionBank[questionIndex].question)")
                            .font(.title)
                        
                        TextField("Answer", text: $textEntered)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.numberPad)
                            .submitLabel(.done)
                            .focused($isFocused)
                           
                        Text("Score: \(score)")
                    }
                } else {
                    Form {
                        Section("Up To") {
                            Stepper("\(upperBound)", value: $upperBound, in: 2...12)
                        }
                        
                        Section("Question Number") {
                            Picker("How many questions?", selection: $selectedQuestionNumber) {
                                ForEach(questionNumberArray, id: \.self) {
                                    Text("\($0)")
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        Button {
                            startGame()
                        } label: {
                            Text("Start Game")
                                .frame(maxWidth: .infinity)
                        }
                    }
                }
            }
            .navigationTitle("Multimate Quiz")
            .toolbar(content: {
                if gameStarted && isFocused && !textEntered.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Done") {
                            isFocused = false
                            handleSubmit()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            })
            .alert(alertTitle, isPresented: $showAlert) {
                Button("OK") {
                    switch alertType {
                    case .correct:
                        score += 1
                        moveToNextQuestion()
                    case .incorrect:
                        score -= 1
                        moveToNextQuestion()
                    case .finish:
                        endGame()
                    }
                }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    
    private func startGame() {
        for _ in (0..<selectedQuestionNumber) {
            let number1 = Int.random(in: 1...upperBound)
            let number2 = Int.random(in: 1...upperBound)
            let correctAnswer = String(number1 * number2)
            
            let question = Question(question: "What is \(number1) * \(number2)?", correctAnswer: correctAnswer)
            
            questionBank.append(question)
        }
        
        gameStarted = true
    }
    
    private func endGame() {
        upperBound = 2
        questionBank = []
        selectedQuestionNumber = 5
        gameStarted = false
    }
    
    private func checkAnwer(answer: String) -> Bool {
        let correctAnswer = questionBank[questionIndex].correctAnswer
        return answer == correctAnswer
    }
    
    private func handleSubmit() {
        checkAnwer(answer: textEntered) ? alert(title: "Correct Answer", message: "Good work +1 Score", type: .correct) : alert(title: "Wrong Answer", message: "Come on -1 Score, correct answer was: \(questionBank[questionIndex].correctAnswer)", type: .incorrect)
    }
    
    private func moveToNextQuestion() {
        if questionIndex < questionBank.count - 1 {
            questionIndex += 1
            textEntered = ""
        } else {
            alert(title: "Game is Finished!", message: "Your score is \(score).", type: .finish)
        }
    }
    
    private func alert(title: String, message: String, type: AlertType) {
        alertTitle = title
        alertMessage = message
        alertType = type
        showAlert = true
    }
}

#Preview {
    ContentView()
}

struct Question {
    let question: String
    let correctAnswer: String
}

struct QuestionView: View {
    let question: Question
    var body: some View {
        Text(question.question)
    }
}

private enum AlertType {
    case correct
    case incorrect
    case finish
}
