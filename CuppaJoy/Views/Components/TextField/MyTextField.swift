//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct MyTextField: View {
  
  let icon: String
  let prompt: String
  @Binding var inputData: String
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: icon)
        .font(.headline)
        .foregroundStyle(.white)
        .opacity(0.7)
      TextField(prompt, text: $inputData)
        .font(.poppins(.regular, size: 14))
    }
    .listRowInsets(
      EdgeInsets(top: 28, leading: 15, bottom: 22, trailing: 15)
    )
  }
}

#Preview {
  MyTextField(
    icon: "swift",
    prompt: "Enter your password",
    inputData: .constant("")
  )
}
