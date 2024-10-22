//
//  BorderedButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct BorderedLabel: View {
    let title: String
    let imageName: String
    
    var body: some View {
        Label(title, systemImage: imageName)
            .font(.poppins(.medium, size: 15))
            .foregroundStyle(.primarySystem)
            .padding(13)
            .background(.primaryMint)
            .clipShape(.buttonBorder)
    }
}
