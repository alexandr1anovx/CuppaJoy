//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct CustomTextField: View {
    let imageName: String
    let placeholder: String
    @Binding var inputData: String
    
    var body: some View {
        VStack {
            HStack(spacing: 15) {
                Image(imageName)
                    .resizable()
                    .frame(width: 23, height: 23)
                    .foregroundStyle(.primaryMint)
                
                TextField(placeholder, text: $inputData)
                    .font(.poppins(.regular, size: 15))
                    .foregroundStyle(.primaryMint)
            }
            Rectangle()
                .frame(height: 0.5)
                .foregroundStyle(.primaryGray)
        }
    }
}

#Preview {
    CustomTextField(
        imageName: "user",
        placeholder: "Enter your password",
        inputData: .constant("")
    )
}
