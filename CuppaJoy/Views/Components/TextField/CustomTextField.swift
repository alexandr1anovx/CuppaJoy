//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct CustomTextField: View {
  
  let image: ImageResource
  let placeholder: String
  @Binding var inputData: String
  
  var body: some View {
    VStack {
      HStack(spacing: 15) {
        Image(image)
          .resizable()
          .frame(width: 20, height: 20)
          .foregroundStyle(.accent)
        TextField(text: $inputData) {
          Text(placeholder)
            .font(.callout)
            .fontWeight(.medium)
            .fontDesign(.rounded)
            .foregroundStyle(.gray)
        }
      }
      CustomSeparator()
    }
  }
}

#Preview {
  CustomTextField(
    image: .man,
    placeholder: "Enter your password",
    inputData: .constant("")
  )
}
