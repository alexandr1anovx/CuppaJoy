//
//  BorderedButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let imageName: String
    let action: () -> Void
    
    init(_ title: String, image: String, action: @escaping () -> Void) {
        self.title = title
        self.imageName = image
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Label(title, systemImage: imageName)
                .font(.poppins(.medium, size: 15))
                .foregroundStyle(.primaryGreen)
                .padding(14)
                .background(.primaryMint)
                .clipShape(.buttonBorder)
        }
    }
}

#Preview {
    RoundedButton("Next", image: "arrow.right") {}
}
