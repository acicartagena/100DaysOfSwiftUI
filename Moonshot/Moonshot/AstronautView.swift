//
//  AstronautView.swift
//  Moonshot
//
//  Created by Angela Cartagena on 13/6/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct AstronautView: View {

    let astronaut: Astronaut
    let astronautMissions: [Mission]

    init(astronaut: Astronaut, moonshotDataProvider: MoonshotDataProvider = MoonshotService.shared) {
        self.astronaut = astronaut

        let missions = moonshotDataProvider.missions

        astronautMissions = missions.filter { mission in
            mission.crew.first (where: { $0.name == astronaut.id }) != nil
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)

                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)

                    ForEach(self.astronautMissions, id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .frame(width: 83, height: 60)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.primary, lineWidth: 1))

                            VStack(alignment: .leading) {
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedLaunchDate)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
}

struct AstronautView_Preivew: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
