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
    HStack(spacing:15) {
      Image(systemName: imageName)
        .font(.headline)
        .foregroundStyle(.white)
        .opacity(0.7)
      TextField(placeholder, text: $inputData)
        .font(.poppins(.regular, size: 13))
    }
    .listRowInsets(
      EdgeInsets(top: 28, leading: 15, bottom: 22, trailing: 15)
    )
  }
}

#Preview {
  CustomTextField(
    imageName: "swift",
    placeholder: "Enter your password",
    inputData: .constant("")
  )
}
