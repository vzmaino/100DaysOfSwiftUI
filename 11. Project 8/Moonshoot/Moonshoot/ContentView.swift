//
//  ContentView.swift
//  Moonshoot
//
//  Created by Vinicius Maino.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var changeCaption = false

    var body: some View {
        
        NavigationView {
            List(missions) { mission in
                
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(changeCaption ? mission.formattedeLauchDate : mission.listCrew)
                    }
                }
                
            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing: Button(changeCaption ? "Show Crew" : "Show Dates") {
                self.changeCaption.toggle()
            }
            )
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
