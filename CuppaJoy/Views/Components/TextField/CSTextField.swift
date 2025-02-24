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
    case .username: "Enter your first and last name"
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
  let isSecure: Bool?
  
  init(
    for fieldContentType: TextFieldContentType,
    inputData: Binding<String>,
    isSecure: Bool? = nil
  ) {
    self.fieldContentType = fieldContentType
    self.isSecure = isSecure
    self._inputData = inputData
  }
  
  var body: some View {
    HStack(spacing: 15) {
      Image(systemName: fieldContentType.icon)
        .imageScale(.medium)
        .foregroundStyle(.csCream)
      
      if isSecure != nil {
        SecureField(fieldContentType.hint, text: $inputData)
      } else {
        TextField(fieldContentType.hint, text: $inputData)
          .font(.system(size: 15))
          .fontWeight(.medium)
      }
    }
    .listRowInsets(
      EdgeInsets(top: 28, leading: 15, bottom: 22, trailing: 15)
    )
  }
}

#Preview {
  CSTextField(for: .password, inputData: .constant(""))
}
