//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Angela Cartagena on 15/3/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    enum FlagAnimation {
        case rotate
        case fade
    }

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score: Int = 0

    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)

    @State private var animationDuration = 1.0

    // correct answer
    @State private var animationRotateDegrees = 0.0
    @State private var animationOpacity = 1.0

    // wrong answer
    @State private var animationShake: Bool = false


    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                ForEach(0..<3) { index in
                    if index == self.correctAnswer {
                        Button(action: {
                            self.flagTapped(index)
                            withAnimation(.easeOut(duration: self.animationDuration)) {
                                self.animationRotateDegrees = 360
                                self.animationOpacity = 0.25
                            }
                        }) {
                            Image(self.countries[index])
                                .renderingMode(.original)
                                .flagImage()
                                .opacity(100.0)
                        }.shake(self.animationShake)
                        .rotation3DEffect(.degrees(self.animationRotateDegrees), axis: (x: 0, y: 1, z: 0))
                    } else {
                        Button(action: {
                            self.flagTapped(index)
                            withAnimation(.default) {
                                self.animationShake = true
                                self.animationOpacity = 0.25
                            }
                        }) {
                            Image(self.countries[index])
                                .renderingMode(.original)
                                .flagImage()
                        }.opacity(self.animationOpacity)
                    }
                }
                Spacer()
            }
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration) {
                self.showingScore = true
            }
        } else {
            scoreTitle = "Wrong that's the flag of \(countries[number])"
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationDuration/2) {
                self.showingScore = true
            }
        }
    }

    func askQuestion() {
        animationRotateDegrees = 0
        animationOpacity = 1.0
        animationShake = false

        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: .black, radius: 2)
    }
}

extension View {
    func flagImage() -> some View {
        self.modifier(FlagImage())
    }
}

struct Shake: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

extension View {
    func shake(_ start: Bool) -> some View {
        let attempts: CGFloat = start ? 1.0 : 0.0
        return self.modifier(Shake(animatableData: attempts))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
