//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Angela Cartagena on 1/7/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {

    @ObservedObject var order: Order

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)

                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)

                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }

        }
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you!"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }

    func placeOrder() {
        do {
            let encoded = try JSONEncoder().encode(order)
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = encoded

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                    return
                }

                if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                    self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                    self.showingConfirmation = true
                } else {
                    print("Invalid response from server")
                }
            }.resume()
        } catch let error {
            print("Failed to encode order: \(error)")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
