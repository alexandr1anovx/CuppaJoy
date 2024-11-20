//
//  InnerShadowModifier.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11/19/24.
//

import SwiftUI

struct InnerShadowViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                Color.primaryBlue
                    .shadow(.inner(color: .black, radius: 2, y: 3))
                    .shadow(.inner(color: .primaryBlack, radius: 2, y: 5))
            )
    }
}

extension View {
    func innerShadowModifier() -> some View {
        modifier(InnerShadowViewModifier())
    }
}
