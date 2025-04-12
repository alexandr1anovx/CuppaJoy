//
//  PasswordTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.02.2025.
//

import SwiftUI

struct SecuredInputField: View {
  
  @Binding var password: String
  @State private var isShownPassword = false
  @FocusState private var inputStatus: InputFieldStatus?
  
  private var isValidField: Bool {
    password.count > 6 && password.count <= 20
  }
  
  var body: some View {
    HStack {
      secureInputField
      Image(systemName: isShownPassword ? "eye" : "eye.slash")
        .opacity(password.count >= 1 ? 1 : 0)
        .disabled(password.count < 1)
        .foregroundStyle(.gray)
        .onTapGesture {
          isShownPassword.toggle()
        }
    }
  }
  
  var secureInputField: some View {
    HStack(spacing: 15) {
      Image(systemName: "lock")
        .frame(width: 18, height: 18)
        .foregroundStyle(.csCream)
        .opacity(0.8)
      if isShownPassword {
        TextField("Password", text: $password)
          .font(.subheadline)
          .keyboardType(.asciiCapable)
          .focused($inputStatus, equals: .notSecured)
      } else {
        SecureField("Password", text: $password)
          .font(.subheadline)
          .keyboardType(.asciiCapable)
          .focused($inputStatus, equals: .secured)
      }
    }
    .textInputAutocapitalization(.never)
    .autocorrectionDisabled(true)
    .onChange(of: isShownPassword) {
      inputStatus = isShownPassword ? .notSecured : .secured
    }
    .onChange(of: password) { _, newValue in
      if newValue.count > 20 {
        password = String(newValue.prefix(20))
      }
    }
  }
}

#Preview {
  SecuredInputField(password: .constant("Password"))
}
