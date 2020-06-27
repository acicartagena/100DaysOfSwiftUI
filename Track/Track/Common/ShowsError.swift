//
//  ShowsError.swift
//  Track
//
//  Created by Angela Cartagena on 27/6/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct ShowsError: ViewModifier {

    let errorMessage: String?
    var showError: Bool {
        return errorMessage != nil
    }

    func body(content: Content) -> some View {
        VStack {
            if showError {
                Text(errorMessage ?? "")
                    .foregroundColor(.red)
                    .font(.caption)
            }
            content
                .foregroundColor(showError ? .red : .black)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                .stroke(Color.red, lineWidth: showError ? 2 : 0)
            )
        }
    }
}

extension View {
    func showsError(with errorMessage: String?) -> some View {
        self.modifier(ShowsError(errorMessage: errorMessage))
    }
}
