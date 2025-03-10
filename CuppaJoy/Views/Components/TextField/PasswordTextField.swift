//
//  PasswordTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.02.2025.
//

import SwiftUI

enum FieldToFocuse {
  case textField, secureField
}

struct PasswordTextField: View {
  
  @Binding var password: String
  @State private var isShownPassword = false
  @FocusState var isFieldFocused: FieldToFocuse?
  
  var body: some View {
    ZStack(alignment: .trailing) {
      secureTextField
      Image(systemName: isShownPassword ? "eye" : "eye.slash")
        .foregroundStyle(.gray)
        .onTapGesture {
          isShownPassword.toggle()
        }
    }
  }
  
  var secureTextField: some View {
    Group {
      if isShownPassword {
        HStack(spacing: 15) {
          Image(systemName: "lock")
            .frame(width: 18, height: 18)
            .foregroundStyle(.csCream)
            .opacity(0.8)
          TextField("Password", text: $password)
            .font(.callout)
            .fontWeight(.medium)
            .keyboardType(.asciiCapable)
            .focused($isFieldFocused, equals: .textField)
        }
      } else {
        HStack(spacing: 15) {
          Image(systemName: "lock")
            .frame(width: 18, height: 18)
            .foregroundStyle(.csCream)
            .opacity(0.8)
          SecureField("Password", text: $password)
            .font(.callout)
            .fontWeight(.medium)
            .keyboardType(.asciiCapable)
            .focused($isFieldFocused, equals: .secureField)
        }
      }
    }
    .textInputAutocapitalization(.never)
    .autocorrectionDisabled(true)
    .onChange(of: isShownPassword) { _, newValue in
      isFieldFocused = isShownPassword ? .textField : .secureField
    }
  }
}

/*
HStack(spacing: 15) {
  Image(systemName: "lock")
    .frame(width: 18, height: 18)
    .foregroundStyle(.csCream)
  
  if isShownPassword {
    TextField("Password", text: $password)
  } else {
    SecureField("Password", text: $password)
  }
  
  Image(systemName: isShownPassword ? "eye" : "eye.slash")
    .foregroundStyle(.gray)
    .onTapGesture {
      isShownPassword.toggle()
    }
}
*/

#Preview {
  PasswordTextField(password: .constant("123456"))
}
