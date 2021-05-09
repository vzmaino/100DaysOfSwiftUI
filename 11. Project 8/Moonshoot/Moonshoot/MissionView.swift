//
//  MissionView.swift
//  Moonshoot
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct MissionView: View {
    
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ScrollView(.vertical) {
                
                VStack {
                    
                    // Project 18 - Challenge 1
                    GeometryReader { imageGeometry in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .padding(.top)
                            .frame(width: imageGeometry.size.width, height: imageGeometry.size.height)
                            .scaleEffect(1 - self.scaleFactor(geometry: geometry, imageGeometry: imageGeometry))
                            .offset(x: 0, y: self.scaleFactor(geometry: geometry, imageGeometry: imageGeometry) * imageGeometry.size.height / 2)
                    }
                    .frame(height: geometry.size.width * 0.75)
                    
                    Text(self.mission.formattedeLauchDate)
                        .padding()
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    // Project 18 - Challenge 1
    func scaleFactor(geometry: GeometryProxy, imageGeometry: GeometryProxy) -> CGFloat {
        let imagePosition = imageGeometry.frame(in: .global).minY
        let safeAreaHeight = geometry.safeAreaInsets.top

        return (safeAreaHeight - imagePosition) / 500

        // if zoom needs to be capped
        //return -min(0.5, (imagePosition - safeAreaHeight) / 500)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name}) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
