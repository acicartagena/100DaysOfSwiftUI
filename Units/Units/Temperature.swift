//
//  Temperature.swift
//  Units
//
//  Created by Angela Cartagena on 29/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

enum Temperature: Int, UnitOption, CaseIterable, CustomStringConvertible {
    case celsius
    case fahrenheit
    case kelvin

    var description: String {
        switch self {
        case .celsius: return "Celsius"
        case .fahrenheit: return "Fahrenheit"
        case .kelvin: return "Kelvin"
        }
    }

    var dimension: Dimension {
        switch self {
        case .celsius: return UnitTemperature.celsius
        case .fahrenheit: return UnitTemperature.fahrenheit
        case .kelvin: return UnitTemperature.kelvin
        }
    }
}

extension Temperature: Identifiable {
    var id: Int {
        return self.rawValue
    }
}
