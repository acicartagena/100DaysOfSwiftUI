//
//  AddView.swift
//  iExpense
//
//  Created by Angela Cartagena on 25/4/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import Foundation
import SwiftUI

struct AddView: View {

    @ObservedObject var expenses: Expenses

    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""

    @Environment(\.presentationMode) var presentationMode

    @State private var showErrorAlert = false
    @State private var errorText = ""

    static let types = ["Personal", "Business"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id:\.self) {
                        Text($0)
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new expense")
            .navigationBarItems(trailing: Button("Save") {
                self.save()
            })
        }.alert(isPresented: $showErrorAlert) {
            Alert(title: Text(errorText))
        }
    }

    func save() {
        guard let actualAmount = Int(amount) else {
            errorText = "Invalid amount: Amount should be a number"
            showErrorAlert = true
            return
        }
        let item = ExpenseItem(name: name, type: type, amount: actualAmount)
        expenses.items.append(item)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
