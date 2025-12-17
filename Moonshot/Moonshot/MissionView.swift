//
//  MissionView.swift
//  Moonshot
//
//  Created by Turker Alan on 18.11.2025.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember: Hashable {
        var id = UUID()
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission

        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
        }
    }

    var body: some View {
        ScrollView {
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                    }
                    .padding(.top)

                Text(mission.formattedLaunchDate)
                    .font(Font.footnote.bold())
                    .padding(.bottom, 5)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing, 10)
                    
                VStack(alignment: .leading) {
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)

                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(crew, id: \.role) { crewMember in
                            NavigationLink(value: crewMember) {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 104, height: 72)
                                        .clipShape(.capsule)
                                        .overlay(
                                            Capsule()
                                                .strokeBorder(.white, lineWidth: 1)
                                        )

                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .foregroundStyle(.white)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                }
                                .padding(.horizontal)
                            }
//                            NavigationLink {
//                                AstronautView(astronaut: crewMember.astronaut)
//                            } label: {
//                                HStack {
//                                    Image(crewMember.astronaut.id)
//                                        .resizable()
//                                        .frame(width: 104, height: 72)
//                                        .clipShape(.capsule)
//                                        .overlay(
//                                            Capsule()
//                                                .strokeBorder(.white, lineWidth: 1)
//                                        )
//
//                                    VStack(alignment: .leading) {
//                                        Text(crewMember.astronaut.name)
//                                            .foregroundStyle(.white)
//                                            .font(.headline)
//                                        Text(crewMember.role)
//                                            .foregroundStyle(.white.opacity(0.5))
//                                    }
//                                }
//                                .padding(.horizontal)
//                            }
                        }
                    }
                }
                .padding(.top, 10)
            }
            .padding(.bottom)
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .navigationDestination(for: CrewMember.self) { selectedCrewMember in
            AstronautView(astronaut: selectedCrewMember.astronaut)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")

    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
