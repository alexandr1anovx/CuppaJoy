//
//  PasswordTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.02.2025.
//

import SwiftUI

enum TextFieldStatus {
  case secured, notSecured
}

struct SecuredTextField: View {
  
  @Binding var password: String
  @State private var isShownPassword = false
  @FocusState var fieldStatus: TextFieldStatus?
  
  private var isValidField: Bool {
    password.count > 6 && password.count <= 20
  }
  
  var body: some View {
    HStack {
      secureTextField
        
      Image(systemName: isShownPassword ? "eye" : "eye.slash")
        .opacity(password.count >= 1 ? 1 : 0)
        .disabled(password.count < 1)
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
            .font(.subheadline)
            .fontWeight(.medium)
            .keyboardType(.asciiCapable)
            .focused($fieldStatus, equals: .notSecured)
        }
      } else {
        HStack(spacing: 15) {
          Image(systemName: "lock")
            .frame(width: 18, height: 18)
            .foregroundStyle(.csCream)
            .opacity(0.8)
          SecureField("Password", text: $password)
            .font(.subheadline)
            .fontWeight(.medium)
            .keyboardType(.asciiCapable)
            .focused($fieldStatus, equals: .secured)
        }
      }
    }
    .textInputAutocapitalization(.never)
    .autocorrectionDisabled(true)
    .onChange(of: isShownPassword) { _, newValue in
      fieldStatus = isShownPassword ? .notSecured : .secured
    }
    .onChange(of: password) { _, newValue in
      if newValue.count > 20 {
        password = String(newValue.prefix(20))
      }
    }
  }
}

#Preview {
  SecuredTextField(password: .constant("Password"))
}
