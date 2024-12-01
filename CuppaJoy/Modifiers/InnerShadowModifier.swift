//
//  InnerShadowModifier.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 30.11.2024.
//

import SwiftUI

struct InnerShadowViewModifier: ViewModifier {
    
    let bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .background(bgColor
                .shadow(.inner(color: .cstBrown, radius: 3, y: 1))
                .shadow(.drop(color: .cstDarkBrown, radius: 2)))
    }
}

extension View {
    func innerShadowModifier(bgColor: Color) -> some View {
        modifier(InnerShadowViewModifier(bgColor: bgColor))
    }
}
