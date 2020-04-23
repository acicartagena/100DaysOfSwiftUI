//
//  SettingsView.swift
//  MultiplicationTables
//
//  Created by Angela Cartagena on 20/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct SettingsView: View {

    let countOptions: [Questions.Count] = Questions.Count.validOptions

    @State var upToValue: Int = 2
    @State var questionCount: Int = 0

    var count: Questions.Count {
        return countOptions[questionCount]
    }

    let onStart: (Questions) -> Void

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        VStack {
                            Text("How many times tables?")
                            Stepper(value: $upToValue, in: 2...12, step: 1) {
                                Text("Up to \(self.upToValue) times tables")
                            }
                        }
                    }
                    Section {
                        VStack {
                            Text("How many questions?")
                            Picker("", selection: $questionCount) {
                                ForEach(0..<countOptions.count) {
                                    Text(self.countOptions[$0].text)
                                }
                            }.pickerStyle(SegmentedPickerStyle())
                        }
                    }
                }
                Spacer()
                Button(action: {
                    self.onStart(Questions(upTo: self.upToValue, count: self.count))
                }) {
                    Text("Start").roundedGradient()
                }

            }.navigationBarTitle("Practice Tables")
        }
    }
}

struct RoundedGradient: ViewModifier {

    let startColor: Color
    let endColor: Color

    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(30.0)
            .padding(.horizontal, 20)
    }
}

extension View {
    func roundedGradient(start: Color = .blue, end: Color = .purple) -> some View {
        self.modifier(RoundedGradient(startColor: start, endColor: end))
    }
}
