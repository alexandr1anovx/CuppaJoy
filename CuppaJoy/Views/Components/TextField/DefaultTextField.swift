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

struct DefaultTextField: View {
  
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
        .frame(width: 18, height: 18)
        .foregroundStyle(.csCream)
        .opacity(0.8)
      TextField(fieldContentType.hint, text: $inputData)
        .font(.subheadline)
        .fontWeight(.medium)
    }
  }
}

#Preview {
  DefaultTextField(for: .password, inputData: .constant(""))
}
