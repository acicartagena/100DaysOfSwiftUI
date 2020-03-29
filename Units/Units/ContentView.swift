//
//  ContentView.swift
//  Units
//
//  Created by Angela Cartagena on 28/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedUnitNumber: Int = 0
    @State private var inputAmount = ""
    @State private var inputUnit: Int = 0
    @State private var outputUnit: Int = 0

    private var selectedUnit: Unit {
        return Unit.allCases[selectedUnitNumber]
    }

    private var selectedUnitOptions: [AnyUnitOption] {
        return selectedUnit.options
    }

    private var outputAmount: Double {
        let amount = Double(inputAmount) ?? 0
        let input = selectedUnitOptions[inputUnit]
        let output = selectedUnitOptions[outputUnit]
        return convert(amount: amount, unit: input, to: output)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Which one?")) {
                    Picker("Unit", selection: $selectedUnitNumber) {
                        ForEach(Unit.allCases) { unit in
                            Text("\(unit.description)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("From")) {
                    TextField("Amount", text: $inputAmount)
                        .keyboardType(.decimalPad)
                    Picker("Unit", selection: $inputUnit) {
                        ForEach(selectedUnitOptions) { option in
                            Text("\(option.description)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("To")) {
                    Picker("Unit", selection: $outputUnit) {
                        ForEach(selectedUnitOptions) { option in
                            Text("\(option.description)")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("\(outputAmount, specifier: "%.2f")")
                }
            }.navigationBarTitle("Units")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
