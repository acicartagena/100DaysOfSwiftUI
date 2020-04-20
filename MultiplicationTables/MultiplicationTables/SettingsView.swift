//
//  SettingsView.swift
//  MultiplicationTables
//
//  Created by Angela Cartagena on 20/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct Questions {

    struct Question {
        let description: String
        let answer: Int
    }

    enum Count {
        case number(Int)
        case all

        var text: String {
            switch self {
            case let .number(count): return "\(count)"
            case .all: return "all"
            }
        }

        static var validOptions: [Count] {
            return [.number(5), .number(10), .number(20), .all]
        }
    }

    let questions: [Question]

    init(upTo: Int, count: Count) {
        var tempQuestions: [Question] = []
        for i in 1...upTo {
            for j in 1...12 {
                let question = Question(description: "\(i) x \(j)", answer: i*j)
                tempQuestions.append(question)
            }
        }

        switch count {
        case let .number(questionCount):
            questions = Array(tempQuestions.shuffled().prefix(questionCount))
        case .all:
            questions = tempQuestions
        }
    }
}

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
    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(30.0)
            .padding(.horizontal, 20)
    }
}

extension View {
    func roundedGradient() -> some View {
        self.modifier(RoundedGradient())
    }
}
