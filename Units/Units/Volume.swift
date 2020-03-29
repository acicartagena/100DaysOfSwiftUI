//
//  Volume.swift
//  Units
//
//  Created by Angela Cartagena on 29/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum Volume: Int, UnitOption, CaseIterable, CustomStringConvertible {
    case milliliters
    case liters
    case cups
    case pints
    case gallons

    var description: String {
        switch self {
        case .milliliters: return "Milliliters"
        case .liters: return "Liters"
        case .cups: return "Cups"
        case .pints: return "Pints"
        case .gallons: return "Gallons"
        }
    }

    var dimension: Dimension {
        switch self {
        case .milliliters: return UnitVolume.milliliters
        case .liters: return UnitVolume.liters
        case .cups: return UnitVolume.cups
        case .pints: return UnitVolume.pints
        case .gallons: return UnitVolume.gallons
        }
    }
}

extension Volume: Identifiable {
    var id: Int {
        return self.rawValue
    }
}
