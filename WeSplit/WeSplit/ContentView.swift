//
//  ContentView.swift
//  WeSplit
//
//  Created by Angela Cartagena on 15/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    let tipPercentages = [10, 15, 20, 25, 0]

    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 2

    private var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)

        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }

    private var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(checkAmount) ?? 0

        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        return grandTotal
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) people")
                        }
                    }
                }
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<self.tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total (including tip)")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                        .foregroundColor(self.tipPercentages[tipPercentage] == 0 ? .red : .black)
                }
            }
        .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
