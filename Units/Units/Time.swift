//
//  Time.swift
//  Units
//
//  Created by Angela Cartagena on 29/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum Time: Int, UnitOption, CaseIterable, CustomStringConvertible {
    case seconds
    case minutes
    case hours

    var description: String {
        switch self {
        case .seconds: return "Seconds"
        case .minutes: return "Minutes"
        case .hours: return "Hours"
        }
    }

    var dimension: Dimension {
        switch self {
        case .seconds: return UnitDuration.seconds
        case .minutes: return UnitDuration.minutes
        case .hours: return UnitDuration.hours
        }
    }
}

extension Time: Identifiable {
    var id: Int {
        return self.rawValue
    }
}
