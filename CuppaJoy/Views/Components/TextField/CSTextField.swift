//
//  CustomTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

enum TextFieldContentType {
  case username
  case emailAddress
  case phoneNumber
  case password
  
  var hint: String {
    switch self {
    case .username: "Name and surname"
    case .emailAddress: "Email address"
    case .phoneNumber: "Phone number"
    case .password: "Password"
    }
  }
  
  var icon: String {
    switch self {
    case .username: "person.crop.circle"
    case .emailAddress: "envelope"
    case .phoneNumber: "phone"
    case .password: "lock"
    }
  }
}

struct CSTextField: View {
  
  let fieldContentType: TextFieldContentType
  @Binding var inputData: String
  
  init(
    for fieldContentType: TextFieldContentType,
    inputData: Binding<String>
  ) {
    self.fieldContentType = fieldContentType
    self._inputData = inputData
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: fieldContentType.icon)
        .imageScale(.medium)
        .foregroundStyle(.csCream)
        .opacity(0.8)
      TextField(fieldContentType.hint, text: $inputData)
        .font(.callout)
        .fontWeight(.medium)
    }
  }
}

#Preview {
  CSTextField(for: .password, inputData: .constant(""))
}
