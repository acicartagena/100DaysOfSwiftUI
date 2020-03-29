//
//  Unit.swift
//  Units
//
//  Created by Angela Cartagena on 29/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

protocol UnitOption: CustomStringConvertible {
    var dimension: Dimension { get }
    var id: Int { get }
}

struct AnyUnitOption: UnitOption, Identifiable {
    private var base: UnitOption

    var description: String {
        return base.description
    }

    var dimension: Dimension {
        return base.dimension
    }

    var id: Int {
        return base.id
    }

    init(_ base: UnitOption) {
        self.base = base
    }
}

enum Unit: Int, CaseIterable {
    case temperature
    case length
    case time
    case volume

    var options: [AnyUnitOption] {
        switch self {
        case .temperature: return Temperature.allCases.map(AnyUnitOption.init)
        case .length: return Length.allCases.map(AnyUnitOption.init)
        case .time: return Time.allCases.map(AnyUnitOption.init)
        case .volume: return Volume.allCases.map(AnyUnitOption.init)
        }
    }
}

extension Unit: CustomStringConvertible {
    var description: String {
        switch self {
        case .temperature: return "Temperature"
        case .length: return "Length"
        case .time: return "Time"
        case .volume: return "Volume"
        }
    }
}

extension Unit: Identifiable {
    var id: Int {
        return self.rawValue
    }
}

func convert<T: UnitOption>(amount: Double, unit input: T, to output: T) -> Double {
    let temperature = Measurement(value: amount, unit: input.dimension)
    return temperature.converted(to: output.dimension).value
}
