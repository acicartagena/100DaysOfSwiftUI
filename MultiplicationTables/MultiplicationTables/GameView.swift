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
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Score: \(correctAnswers)")
                        .padding()

                }
                Text("\(questions.questions[questionIndex].description)?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                TextField("Answer", text: $answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.numberPad)
                Spacer()
                Button(action: {
                    self.checkAnswer()
                }) {
                    Text("Check")
                        .roundedGradient()
                }.padding()
            }.navigationBarItems(trailing:
                Button("Cancel") {
                    self.quit()
                }
            )
        }
    }

    func checkAnswer() {

    }

    func quit() {

    }
}

struct ContentView_Previews1: PreviewProvider {
    static var previews: some View {
        GameView(questions: Questions(upTo: 2, count: .all))
    }
}
