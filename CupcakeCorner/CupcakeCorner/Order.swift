//
//  Order.swift
//  CupcakeCorner
//
//  Created by Angela Cartagena on 1/7/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

class ObservableOrder: ObservableObject {
    @Published var order: Order

    init(order: Order = Order()) {
        self.order = order
    }

    var cost: Double {
        order.cost
    }

    var hasValidAddress: Bool {
        order.hasValidAddress
    }


    var type: Int {
        get { order.type }
        set { order.type = newValue }
    }

    var quantity: Int {
        get { order.quantity }
        set { order.quantity = newValue }
    }

    var specialRequestEnabled: Bool {
        get { order.specialRequestEnabled }
        set { order.specialRequestEnabled = newValue }
    }

    var extraFrosting: Bool {
        get { order.extraFrosting }
        set { order.extraFrosting = newValue }
    }

    var addSprinkles: Bool {
        get { order.addSprinkles }
        set { order.addSprinkles = newValue }
    }

    var name: String {
        get { order.name }
        set { order.name = newValue }
    }

    var streetAddress: String {
        get { order.streetAddress }
        set { order.streetAddress = newValue }
    }

    var city: String {
        get { order.city }
        set { order.city = newValue }
    }

    var zip: String {
        get { order.zip }
        set { order.zip = newValue }
    }

    func encoded() throws -> Data {
        return try JSONEncoder().encode(order)
    }
}

struct Order: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]

    var hasValidAddress: Bool {

        let processName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let processStreetAddress = streetAddress.trimmingCharacters(in: .whitespacesAndNewlines)
        let processCity = city.trimmingCharacters(in: .whitespacesAndNewlines)
        let processZip = zip.trimmingCharacters(in: .whitespacesAndNewlines)

        if processName.isEmpty || processStreetAddress.isEmpty || processCity.isEmpty || processZip.isEmpty {
            return false
        }

        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }

    var type = 0
    var quantity = 3

    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false

    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
}
