//
//  ContentView.swift
//  Moonshot
//
//  Created by Turker Alan on 15.11.2025.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var isGrid: Bool = true
    
    var body: some View {
        NavigationStack {
            Group {
                if isGrid {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(missions) { mission in
                                NavigationLink(value: mission) {
                                    missionGridItem(mission)
                                }
//                                NavigationLink {
//                                    MissionView(mission: mission, astronauts: astronauts)
//                                } label: {
//                                    missionGridItem(mission)
//                                }
                            }
                        }
                        .padding([.horizontal, .bottom])
                    }
                } else {
                    List(missions) { mission in
                        NavigationLink(value: mission) {
                            missionListItem(mission)
                        }
//                        NavigationLink {
//                            MissionView(mission: mission, astronauts: astronauts)
//                        } label: {
//                            missionListItem(mission)
//                        }
                        .listRowBackground(Color.darkBackground)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .background(.darkBackground)
                }
            }
            .navigationDestination(for: Mission.self, destination: { selectedMission in
                MissionView(mission: selectedMission, astronauts: astronauts)
            })
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        togglePresentation()
                    } label: {
                        Image(systemName: isGrid ? "list.dash" : "square.grid.3x3.square")
                            .font(.caption)
                            .fontWeight(.bold)
                    }
                    
                }
            }
        }
    }
    
    private func togglePresentation() {
        isGrid.toggle()
    }
    
    @ViewBuilder
    func missionGridItem(_ mission: Mission) -> some View {
        VStack {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack {
                Text(mission.displayName)
                    .font(.headline)
                    .foregroundStyle(.white)
                
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
            }
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(.lightBackground)
        }
        .clipShape(.rect(cornerRadius: 10))
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.lightBackground)
        )
    }
    
    @ViewBuilder
    func missionListItem(_ mission: Mission) -> some View {
        HStack(spacing: 16) {
            Image(mission.image)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
            
            VStack(alignment: .leading) {
                Text(mission.displayName)
                    .font(.headline)
                Text(mission.formattedLaunchDate)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(width: .infinity)
        .padding(20)
    }
}

#Preview {
    ContentView()
}
