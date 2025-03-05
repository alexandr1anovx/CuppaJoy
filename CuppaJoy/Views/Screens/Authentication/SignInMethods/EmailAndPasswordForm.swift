//
//  SignInWithEmailPasswordForm.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct EmailAndPasswordForm: View {
  
  @State private var emailAddress = ""
  @State private var password = ""
  @Binding var selectedMethod: SignInMethod?
  @FocusState private var fieldContent: TextFieldContentType?
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  private var isValidForm: Bool {
    authViewModel.isValidEmail(emailAddress)
    && authViewModel.isValidPassword(password)
  }
  
  init(_ selectedMethod: Binding<SignInMethod?>) {
    self._selectedMethod = selectedMethod
  }
  
  var body: some View {
    VStack(spacing: 20) {
      List {
        CSTextField(for: .emailAddress, inputData: $emailAddress)
          .focused($fieldContent, equals: .emailAddress)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.next)
          .onSubmit { fieldContent = .password }
        
        PasswordTextField(password: $password)
          .focused($fieldContent, equals: .password)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.done)
          .onSubmit { fieldContent = nil }
      }
      .frame(height: 135)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      SignInButton(with: $emailAddress, and: $password)
        .disabled(!isValidForm)
        .opacity(!isValidForm ? 0.5 : 1)
      
      Label("Other methods", systemImage: "arrow.backward.circle.fill")
        .fontWeight(.medium)
        .foregroundStyle(.csCream)
        .onTapGesture { selectedMethod = .none }
    }
  }
}

private struct SignInButton: View {
  
  @Binding var emailAddress: String
  @Binding var password: String
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  init(
    with emailAddress: Binding<String>,
    and password: Binding<String>
  ) {
    self._emailAddress = emailAddress
    self._password = password
  }
  
  var body: some View {
    Button {
      Task {
        await authViewModel.signIn(with: emailAddress, and: password)
      }
    } label: {
      ButtonLabel("Sign In", textColor: .white, pouring: .black)
    }
  }
}
