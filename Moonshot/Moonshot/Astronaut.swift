//
//  Astronaut.swift
//  Moonshot
//
//  Created by Angela Cartagena on 31/5/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

struct Astronaut {
    let id: String
    let name: String
    let description: String
}

extension Astronaut: Codable { }
extension Astronaut: Identifiable { }
