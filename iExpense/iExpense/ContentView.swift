//
//  ContentView.swift
//  iExpense
//
//  Created by Angela Cartagena on 25/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpenses = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text("$\(item.amount)")
                            .padding()
                            .style(amount: item.amount)
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationBarTitle("iExpenses")
            .navigationBarItems(trailing:
                HStack {
                    EditButton()
                        .padding()
                    Button(action: {
                        self.showingAddExpenses = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            )
        }.sheet(isPresented: $showingAddExpenses) {
            AddView(expenses: self.expenses)
        }
    }

    func removeItem(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct StyleAmount: ViewModifier {
    let amount: Int

    var textColor: Color {
        if amount < 10 {
            return .green
        } else if amount > 100 {
            return .red
        } else {
            return .black
        }
    }

    func body(content: Content) -> some View {
        content
            .foregroundColor(textColor)
    }
}

extension View {
    func style(amount: Int) -> some View {
        modifier(StyleAmount(amount: amount))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
