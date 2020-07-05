//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Angela Cartagena on 1/7/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {

    @ObservedObject var order: ObservableOrder

    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false

    @State private var showingError = false
    @State private var errorMessage = ""

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

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
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
        .navigationBarTitle("Check out", displayMode: .inline)
    }

    func placeOrder() {
        do {
            let encoded = try order.encoded()
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = encoded

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                    self.show(error: error)
                    return
                }

                if let error = error {
                    self.show(error: error)
                    return
                }

                do {
                    let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                    self.alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                    self.showingAlert = true
                    self.alertTitle = "Thank you!"
                } catch let error {
                    self.show(error: error)
                    print("decoding error: \(error)")
                }
            }.resume()
        } catch let error {
            self.show(error: error)
        }
    }

    func show(error: Error? = nil) {
        self.showingAlert = true
        self.alertMessage = error?.localizedDescription ?? "Unknonw error"
        self.alertTitle = "Error"
        print("error: \(String(describing: error))")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: ObservableOrder())
    }
}
