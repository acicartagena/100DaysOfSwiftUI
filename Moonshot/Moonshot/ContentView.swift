//
//  ContentView.swift
//  Moonshot
//
//  Created by Angela Cartagena on 31/5/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut]
    let missions: [Mission]

    let displayOptions = ["Launch", "Crew"]
    @State private var selectedDisplayOption = 0

    init(service: MoonshotDataProvider = MoonshotService.shared) {
        self.astronauts = service.astronauts
        self.missions = service.missions
    }

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission)) {
                    Image(mission.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 44)

                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)

                        if self.displayOptions[self.selectedDisplayOption] == "Launch" {
                            Text(mission.formattedLaunchDate)
                        } else {
                            Text(mission.formattedCrewNames)
                        }

                    }
                }

            }
            .navigationBarTitle("Moonshot")
            .navigationBarItems(trailing:
                Picker("Display Options", selection: $selectedDisplayOption) {
                    ForEach(0 ..< displayOptions.count) {
                        Text(self.displayOptions[$0])
                    }
                }.pickerStyle(SegmentedPickerStyle())
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
