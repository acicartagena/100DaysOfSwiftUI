//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Angela Cartagena on 1/7/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct AddressView: View {

    @ObservedObject var order: ObservableOrder

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Stret Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: ObservableOrder())
    }
}
