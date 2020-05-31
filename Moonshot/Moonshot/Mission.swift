//
//  Mission.swift
//  Moonshot
//
//  Created by Angela Cartagena on 31/5/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

struct Mission {
    struct CrewRole {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
}

extension Mission {
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }

    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}

extension Mission: Identifiable { }

extension Mission: Codable { }
extension Mission.CrewRole: Codable { }

