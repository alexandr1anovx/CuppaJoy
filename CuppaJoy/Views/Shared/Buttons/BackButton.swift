//
//  DismissXButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 09.10.2024.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .fill(.primaryMint)
                .frame(width: 30, height: 30)
                .overlay {
                    Image(systemName: "arrow.left")
                        .font(.footnote)
                        .foregroundStyle(.primaryGreen)
                }
        }
    }
}

#Preview {
    BackButton()
}
