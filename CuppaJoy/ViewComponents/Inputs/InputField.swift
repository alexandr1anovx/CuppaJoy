//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct InputField: View {
  
  let inputType: InputContentType
  @Binding var inputData: String
  
  init(
    for inputType: InputContentType,
    data: Binding<String>
  ) {
    self.inputType = inputType
    self._inputData = data
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: inputType.iconName)
        .frame(
          width: UIConstants.Sizes.mediumIcon,
          height: UIConstants.Sizes.mediumIcon
        )
        .foregroundStyle(.csCream)
        .opacity(UIConstants.Opacity.inputField)
      TextField(inputType.hint, text: $inputData)
        .font(.subheadline)
    }
  }
}

#Preview {
  InputField(for: .password, data: .constant(""))
}
