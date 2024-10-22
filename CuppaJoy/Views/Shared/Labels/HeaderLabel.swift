//
//  HeaderLabels.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct HeaderLabel: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(title)
                .font(.poppins(.medium, size: 22))
            Text(subtitle)
                .font(.poppins(.regular, size: 14))
        }
        .foregroundStyle(.primaryMint)
    }
}

#Preview {
    HeaderLabel(
        title: "Forgot Password?",
        subtitle: "Enter your email address"
    )
}
