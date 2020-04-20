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
    case game
}

struct ContentView: View {

    @State var activeScreen: Screen = .settings

    var body: some View {
        Group {
            if activeScreen == .settings {
                SettingsView() { _ in
                    self.activeScreen = .game
                }
            } else {
                GameView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
