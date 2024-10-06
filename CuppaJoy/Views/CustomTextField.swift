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
            HStack {
                Image(systemName: imageName)
                    .foregroundStyle(.darkBrown)
                    .font(.callout)
                Rectangle()
                    .fill(.hotGray)
                    .frame(width: 0.5, height: 20)
                
                TextField(placeholder, text: $inputData)
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.darkBrown)
            }
            Rectangle()
                .fill(Color.hotGray)
                .frame(height: 0.5)
                .padding(.top, 5)
        }
    }
}
