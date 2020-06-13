//
//  MoonshotService.swift
//  Moonshot
//
//  Created by Angela Cartagena on 13/6/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

protocol MoonshotDataProvider {
    var astronauts: [Astronaut] { get }
    var missions: [Mission] { get }
}

class MoonshotService: MoonshotDataProvider {

    static let shared = MoonshotService()

    private init() { }

    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
}
