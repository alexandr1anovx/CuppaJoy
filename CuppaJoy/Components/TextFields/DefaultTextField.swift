//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct DefaultTextField: View {
  
  let inputType: TextFieldInputType
  @Binding var inputData: String
  
  init(
    for inputType: TextFieldInputType,
    inputData: Binding<String>
  ) {
    self.inputType = inputType
    self._inputData = inputData
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: inputType.icon)
        .frame(width: 18, height: 18)
        .foregroundStyle(.csCream)
        .opacity(0.8)
      TextField(inputType.hint, text: $inputData)
        .font(.subheadline)
    }
  }
}

#Preview {
  DefaultTextField(for: .password, inputData: .constant(""))
}
