//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Angela Cartagena on 1/7/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct AddressView: View {

    @ObservedObject var order: Order

    var body: some View {
        Text("Hello world")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
