//
//  ContentView.swift
//  iExpense
//
//  Created by Angela Cartagena on 25/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    var name: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Hello \(name)")
            Button("Dismiss") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct ContentView: View {

    @State private var showingSheet = false
    var body: some View {
        Button("Show sheet") {
            self.showingSheet.toggle()
        }.sheet(isPresented: $showingSheet) {
            SecondView(name: "Angela")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
