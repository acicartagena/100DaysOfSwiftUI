//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Angela Cartagena on 1/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .prominentText()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ProminentText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func prominentText() -> some View {
        self.modifier(ProminentText())
    }
}
