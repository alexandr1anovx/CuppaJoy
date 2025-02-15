//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct CSTextField: View {
  
  let icon: String
  let hint: String
  @Binding var inputData: String
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: icon)
        .imageScale(.medium)
        .foregroundStyle(.csDesert)
      TextField(hint, text: $inputData)
        .font(.subheadline)
        .fontDesign(.monospaced)
    }
    .listRowInsets(
      EdgeInsets(top: 28, leading: 15, bottom: 22, trailing: 15)
    )
  }
}

#Preview {
  CSTextField(
    icon: "swift",
    hint: "Enter your password",
    inputData: .constant("")
  )
}
