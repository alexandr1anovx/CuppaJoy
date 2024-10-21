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
            HStack(spacing: 8) {
                Image(systemName: imageName)
                    .font(.callout)
                    .foregroundStyle(.primaryReversed)
                
                Divider()
                    .frame(height: 20)
                
                TextField(placeholder, text: $inputData)
                    .font(.poppins(.regular, size: 15))
                    .foregroundStyle(.primaryReversed)
            }
            Divider()
        }
    }
}

#Preview {
    CustomTextField(
        imageName: "lock",
        placeholder: "Enter your password",
        inputData: .constant("")
    )
}
