//
//  HeaderView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 27.11.2024.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.poppins(.medium, size: 22))
            Text(subtitle)
                .font(.poppins(.regular, size: 13))
                .foregroundStyle(.primaryWhite)
        }
        .foregroundStyle(.primaryMint)
    }
}

#if DEBUG
#Preview {
    HeaderView(
        title: "Forgot Password?",
        subtitle: "Enter your email address"
    )
}
#endif
