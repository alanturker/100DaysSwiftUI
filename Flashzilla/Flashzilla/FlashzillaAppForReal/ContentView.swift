//
//  ContentView.swift
//  Flashzilla
//
//  Created by Turker Alan on 19.12.2025.
//

import SwiftUI
import Combine

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled

    @State private var cards = [Card]()
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var showingEditScreen = false
    
    var body: some View {
        ZStack {
            Image(decorative: "background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                
                ZStack {
                    ForEach(cards) { card in
                        CardView(card: card) { wasCorrect in
                            withAnimation {
                                handleAnswer(for: card, wasCorrect: wasCorrect)
                            }
                        }
                        .stacked(at: index(of: card), in: cards.count)
                        .allowsHitTesting(isTop(card))
                        .accessibilityHidden(!isTop(card))
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundStyle(.black)
                        .clipShape(.capsule)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button {
                        showingEditScreen = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                            .clipShape(.circle)
                    }
                }
                
                Spacer()
            }
            .foregroundStyle(.white)
            .font(.largeTitle)
            .padding()
            
            if accessibilityDifferentiateWithoutColor || accessibilityVoiceOverEnabled {
                VStack {
                    Spacer()

                    HStack {
                        Button {
                            withAnimation {
                                if let lastCard = cards.last {
                                    removeCard(card: lastCard)
                                }
                            }
                        } label: {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Wrong")
                        .accessibilityHint("Mark your answer as being incorrect.")

                        Spacer()

                        Button {
                            withAnimation {
                                if let lastCard = cards.last {
                                    removeCard(card: lastCard)
                                }
                            }
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(.black.opacity(0.7))
                                .clipShape(.circle)
                        }
                        .accessibilityLabel("Correct")
                        .accessibilityHint("Mark your answer as being correct.")
                    }
                    .foregroundStyle(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
        .sheet(isPresented: $showingEditScreen, onDismiss: resetCards) {
            EditCards()
        }
        .onAppear(perform: resetCards)
    }
    
    private func handleAnswer(for card: Card, wasCorrect: Bool) {
        removeCard(card: card)
        
        if !wasCorrect {
            insertBackRandomNotOnTop(card)
        }
    }
    
    private func insertBackRandomNotOnTop(_ card: Card) {
        let count = cards.count
        
        let insertionIndex: Int
        if count <= 1 {
            insertionIndex = 0
        } else {
            insertionIndex = Int.random(in: 0...(count - 1))
        }
        var tempCard = card
        tempCard.id = UUID()
        
        cards.insert(tempCard, at: insertionIndex)
    }
    
    private func removeCard(card: Card) {
        guard let idx = cards.firstIndex(where: { $0.id == card.id }) else { return }
        cards.remove(at: idx)
    }
    
    private func index(of card: Card) -> Int {
        cards.firstIndex(where: { $0.id == card.id }) ?? 0
    }
    
    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    private func isTop(_ card: Card) -> Bool {
        cards.last?.id == card.id
    }
}

#Preview {
    ContentView()
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(y: offset * 10)
    }
}
