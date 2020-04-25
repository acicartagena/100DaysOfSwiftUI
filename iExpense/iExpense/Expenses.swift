//
//  Expenses.swift
//  iExpense
//
//  Created by Angela Cartagena on 25/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}

extension ExpenseItem: Codable { }

final class Expenses: ObservableObject {

    private static let itemKey = "Items"

    @Published var items: [ExpenseItem] {
        didSet {
            do {
                let encoder = JSONEncoder()
                let encoded = try encoder.encode(items)
                UserDefaults.standard.set(encoded, forKey: Expenses.itemKey)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }

    init() {
        guard let savedItems = UserDefaults.standard.data(forKey: Expenses.itemKey) else {
            items = []
            return
        }
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode([ExpenseItem].self, from: savedItems)
            items = decoded
        } catch let error {
            print(error.localizedDescription)
            items = []
        }
    }
}
