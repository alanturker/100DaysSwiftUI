//
//  ContentView.swift
//  DicerRoller
//
//  Created by Turker Alan on 22.12.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var store = RollStore()
    
    private let availableSides = [4, 6, 8, 10, 12, 20, 100]
    
    @State private var diceCount: Int = 2
    @State private var sides: Int = 6
    
    @State private var currentValues: [Int] = [1, 1]
    @State private var isRolling = false
    
    // Flicker settings
    @State private var flickerTimer: Timer?
    @State private var ticksRemaining: Int = 0
    private let flickerTicksTotal = 14
    private let flickerInterval: TimeInterval = 0.06
    
    @State private var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    
                    // Current roll display
                    GroupBox("Current Roll") {
                        VStack(spacing: 12) {
                            diceGrid(values: currentValues)
                                .animation(.default, value: currentValues)
                            
                            HStack {
                                Text("Total:")
                                Spacer()
                                Text("\(currentValues.reduce(0, +))")
                                    .font(.headline)
                            }
                        }
                        .padding(.top, 4)
                    }
                    
                    // Controls
                    GroupBox("Dice Settings") {
                        VStack(spacing: 12) {
                            Stepper("Dice: \(diceCount)", value: $diceCount, in: 1...12)
                                .onChange(of: diceCount) { _, newValue in
                                    // Keep displayed values array in sync
                                    if newValue > currentValues.count {
                                        currentValues.append(contentsOf: Array(repeating: 1, count: newValue - currentValues.count))
                                    } else if newValue < currentValues.count {
                                        currentValues = Array(currentValues.prefix(newValue))
                                    }
                                }
                            
                            Picker("Sides", selection: $sides) {
                                ForEach(availableSides, id: \.self) { s in
                                    Text("d\(s)").tag(s)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    
                    // Roll button
                    Button {
                        startFlickerRoll()
                    } label: {
                        HStack {
                            Image(systemName: "dice")
                            Text(isRolling ? "Rolling..." : "Roll")
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(isRolling)
                    
                    // History
                    historySection
                    
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .navigationTitle("Dice Roller")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        showAlert = true
                    } label: {
                        Image(systemName: "trash")
                    }
                    .disabled(store.history.isEmpty)
                }
            }
            .onAppear {
                // Ensure initial values match default count
                currentValues = Array(repeating: 1, count: diceCount)
            }
            .alert("Are you sure?", isPresented: $showAlert) {
                Button("Delete", role: .destructive) { store.clear() }
                
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("History will be cleared")
            }
        }
    }
    
    // MARK: - UI Pieces
    
    @ViewBuilder
    private func diceGrid(values: [Int]) -> some View {
        let cols = Array(repeating: GridItem(.flexible(), spacing: 10), count: min(4, max(1, Int(ceil(sqrt(Double(values.count)))))))
        LazyVGrid(columns: cols, spacing: 10) {
            ForEach(values.indices, id: \.self) { idx in
                dieView(value: values[idx], sides: sides)
            }
        }
    }
    
    private func dieView(value: Int, sides: Int) -> some View {
        VStack(spacing: 6) {
            Text("d\(sides)")
                .font(.caption)
                .foregroundStyle(.secondary)
            
            Text("\(value)")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .frame(width: 68, height: 68)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(Color.secondary.opacity(0.25))
                )
        }
    }
    
    private var historySection: some View {
        GroupBox("History") {
            if store.history.isEmpty {
                Text("No rolls yet. Hit Roll!")
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 4)
            } else {
                List {
                    ForEach(store.history) { record in
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                Text("\(record.count) × d\(record.sides)")
                                    .font(.headline)
                                Spacer()
                                Text("Total \(record.total)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Text(record.results.map(String.init).joined(separator: " • "))
                                .font(.subheadline)
                            
                            Text(record.date.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
                .listStyle(.plain)
                .frame(height: 260)
            }
        }
    }
    
    // MARK: - Rolling Logic (Flicker with Timer)
    
    private func startFlickerRoll() {
        guard !isRolling else { return }
        
        isRolling = true
        ticksRemaining = flickerTicksTotal
        
        // Cancel any existing timer safely
        flickerTimer?.invalidate()
        flickerTimer = nil
        
        Haptics.lightTap()
        
        flickerTimer = Timer.scheduledTimer(withTimeInterval: flickerInterval, repeats: true) { _ in
            // Update values quickly (flicker effect)
            currentValues = (0..<diceCount).map { _ in
                Int.random(in: 1...sides)
            }
            
            Haptics.lightTap()
            
            ticksRemaining -= 1
            if ticksRemaining <= 0 {
                finishRoll()
            }
        }
    }
    
    private func finishRoll() {
        flickerTimer?.invalidate()
        flickerTimer = nil
        
        // Final “settled” roll (could be the last flicker values, but we re-roll once for clarity)
        let final = (0..<diceCount).map { _ in Int.random(in: 1...sides) }
        currentValues = final
        
        store.add(RollRecord(sides: sides, count: diceCount, results: final))
        
        isRolling = false
        Haptics.success()
    }
}

#Preview {
    ContentView()
}

@Observable
final class RollStore {
    private(set) var history: [RollRecord] = []
    
    private let fileName = "roll_history.json"
    
    init() {
        load()
    }
    
    func add(_ record: RollRecord) {
        history.insert(record, at: 0)
        save()
    }
    
    func clear() {
        history.removeAll()
        save()
    }
    
    private func fileURL() -> URL {
        let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docs.appendingPathComponent(fileName)
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(history)
            try data.write(to: fileURL(), options: [.atomic])
        } catch {
            print("Save error:", error)
        }
    }
    
    private func load() {
        do {
            let url = fileURL()
            guard FileManager.default.fileExists(atPath: url.path) else { return }
            let data = try Data(contentsOf: url)
            history = try JSONDecoder().decode([RollRecord].self, from: data)
        } catch {
            print("Load error:", error)
            history = []
        }
    }
}

enum Haptics {
    static func lightTap() {
        let gen = UIImpactFeedbackGenerator(style: .light)
        gen.prepare()
        gen.impactOccurred()
    }
    
    static func success() {
        let gen = UINotificationFeedbackGenerator()
        gen.prepare()
        gen.notificationOccurred(.success)
    }
}
