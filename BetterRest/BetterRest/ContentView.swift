//
//  ContentView.swift
//  BetterRest
//
//  Created by Angela Cartagena on 1/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    private static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }

    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1

    private let dateRange = Date()...Date().addingTimeInterval(86400)

    var idealBedtime: String {
        let wakeUpComponents = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hourInSeconds = (wakeUpComponents.hour ?? 0) * 60 * 60
        let minuteInSeconds = (wakeUpComponents.minute ?? 0) * 60

        let model = SleepCalculator()
        do {
            let prediction = try model
                .prediction(wake: Double(hourInSeconds + minuteInSeconds),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep

            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return "Ideal bedtime is at \(formatter.string(from: sleepTime))"
        } catch {
            return "Sorry, there was a problem calculating your bedtime"
        }
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    VStack(alignment: .center) {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .datePickerStyle(WheelDatePickerStyle())
                    }

                }
                Section {
                    VStack {
                        Text("Desired amount of sleep")
                            .font(.headline)
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    }
                }
                Section {
                    VStack {
                        Text("Daily coffee intake")
                            .font(.headline)
                        Stepper(value: $coffeeAmount, in: 1...20) {
                            Text("\(coffeeAmount) \(coffeeAmount == 1 ? "cup" : "cups")")
                        }
                    }
                }
                Section {
                    Text(idealBedtime)
                    .font(.headline)
                }
            }
            .navigationBarTitle("BetterRest")
        }

    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
