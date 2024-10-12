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
                Image(imageName)
                    .resizable()
                    .frame(width: 21, height: 20)
                    .foregroundStyle(.customReversed)
                    
                    .font(.callout)
                Rectangle()
                    
                    .frame(width: 0.5, height: 20)
                
                TextField(placeholder, text: $inputData)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.customReversed)
                    
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
