//
//  GameView.swift
//  MultiplicationTables
//
//  Created by Angela Cartagena on 20/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct GameView: View {

    let questions: Questions

    @State var questionIndex = 0
    @State var answer = ""
    @State var correctAnswers = 0

    @State var gameOver = false

    private var currentQuestion: Questions.Question {
        return questions.questions[questionIndex]
    }

    private var questionText: String {
        return gameOver ? "Game over" : "\(currentQuestion.description)?"
    }

    private var checkStartColor: Color {
        return gameOver ? .gray : .blue
    }

    private var checkEndColor: Color {
        return gameOver ? .gray : .purple
    }

    let onGameEnd: () -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Score: \(correctAnswers)")
                        .padding()

                }
                Text(questionText)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                TextField("Answer", text: $answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.numberPad)
                    .disabled(gameOver)
                Spacer()
                if gameOver {
                    Button(action: {
                        self.goToSettings()
                    }) {
                        Text("Try again")
                            .roundedGradient(start: .red, end: .orange)
                    }.padding(.leading)
                        .padding(.trailing)
                }
                Button(action: {
                    self.checkAnswer()
                }) {
                    Text("Check")
                        .roundedGradient(start: checkStartColor, end: checkEndColor)
                }.padding()
                .disabled(gameOver)
            }.navigationBarItems(trailing:
                Button("Cancel") {
                    self.goToSettings()
                }
            )
        }
    }

    func checkAnswer() {
        if Int(answer) == currentQuestion.answer {
            correctAnswers += 1
        }

        questionIndex += 1
        gameOver = questionIndex >= questions.questions.count
        answer = ""
    }

    func goToSettings() {
        onGameEnd()
    }
}
