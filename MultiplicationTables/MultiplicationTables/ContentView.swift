//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Angela Cartagena on 19/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

enum Screen {
    case settings
    case game(Questions)
}

struct ContentView: View {

    @State var activeScreen: Screen = .settings

    var body: some View {
        Group {
            containedView()
        }
    }

    func containedView() -> AnyView {
        switch activeScreen {
        case .game(let questions):
            return AnyView(GameView(questions: questions) {
                self.activeScreen = .settings
            })
        case .settings:
            return AnyView(SettingsView() { questions in
                self.activeScreen = .game(questions)
            })
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
