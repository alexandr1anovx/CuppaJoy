//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct CustomTextField: View {
    let image: String
    let placeholder: String
    @Binding var inputData: String
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(image)
                    .resizable()
                    .frame(width: 23, height: 23)
                    .foregroundStyle(.cstMint)
                TextField(text: $inputData) {
                    Text(placeholder)
                        .font(.poppins(.medium, size: 13))
                        .foregroundStyle(.cstGray)
                }
            }
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(.cstGray)
        }
    }
}

#Preview {
    CustomTextField(
        image: "user",
        placeholder: "Enter your password",
        inputData: .constant("")
    )
}
