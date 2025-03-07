//
//  PasswordTextField.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.02.2025.
//

import SwiftUI

struct PasswordTextField: View {
  
  @Binding var password: String
  @State private var isShownPassword = false
  
  var body: some View {
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
        .animation(.default, value: isShownPassword)
    }
  }
}

#Preview {
  PasswordTextField(password: .constant("123456"))
}
