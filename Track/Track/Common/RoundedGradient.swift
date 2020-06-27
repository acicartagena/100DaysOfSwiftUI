//
//  RoundedGradient.swift
//  Track
//
//  Created by Angela Cartagena on 27/6/20.
//  Copyright © 2020 ACartagena. All rights reserved.
//

import SwiftUI

struct RoundedGradient: ViewModifier {

    let startColor: Color
    let endColor: Color

    func body(content: Content) -> some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [startColor, endColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(30.0)
            .padding(.horizontal, 20)
    }
}

extension View {
    func roundedGradient(start: Color = .blue, end: Color = .purple) -> some View {
        self.modifier(RoundedGradient(startColor: start, endColor: end))
    }
}
