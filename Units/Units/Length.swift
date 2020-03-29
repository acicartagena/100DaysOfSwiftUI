//
//  Length.swift
//  Units
//
//  Created by Angela Cartagena on 29/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum Length: Int, UnitOption, CaseIterable, CustomStringConvertible {
    case meters
    case kilometers
    case feet
    case yards
    case miles

    var description: String {
        switch self {
        case .meters: return "Meters"
        case .kilometers: return "Kilometers"
        case .feet: return "Feet"
        case .yards: return "Yards"
        case .miles: return "Miles"
        }
    }

    var dimension: Dimension {
        switch self {
        case .meters: return UnitLength.meters
        case .kilometers: return UnitLength.kilometers
        case .feet: return UnitLength.feet
        case .yards: return UnitLength.yards
        case .miles: return UnitLength.miles
        }
    }
}

extension Length: Identifiable {
    var id: Int {
        return self.rawValue
    }
}
