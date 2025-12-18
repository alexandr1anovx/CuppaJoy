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
  @FocusState private var inputStatus: InputContentStatus?
  
  var body: some View {
    HStack {
      secureInputField
      Image(systemName: isShownPassword ? "eye" : "eye.slash")
        .opacity(!password.isEmpty ? 1:0)
        .disabled(password.isEmpty)
        .foregroundStyle(.gray)
        .onTapGesture {
          isShownPassword.toggle()
        }
    }
  }
  
  var secureInputField: some View {
    HStack(spacing: 15) {
      Image(systemName: "lock")
        .frame(
          width: UIConstants.Sizes.mediumIcon,
          height: UIConstants.Sizes.mediumIcon
        )
        .foregroundStyle(.csCream)
      if isShownPassword {
        TextField("Password", text: $password)
          .focused($inputStatus, equals: .notSecured)
          .keyboardType(.asciiCapable)
          
      } else {
        SecureField("Password", text: $password)
          .focused($inputStatus, equals: .secured)
          .keyboardType(.asciiCapable)
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
  SecuredInputField(password: .constant("1"))
}
