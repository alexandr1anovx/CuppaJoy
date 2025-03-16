//
//  SignInWithEmailPasswordForm.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct EmailAndPasswordForm: View {
  
  @State private var isShownHome = false
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
        DefaultTextField(for: .emailAddress, inputData: $emailAddress)
          .focused($fieldContent, equals: .emailAddress)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.next)
          .onSubmit { fieldContent = .password }
        
        SecuredTextField(password: $password)
          .focused($fieldContent, equals: .password)
          .submitLabel(.done)
          .onSubmit { fieldContent = nil }
      }
      .frame(height: 140)
      .environment(\.defaultMinListRowHeight, 50)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      signInButton
      
      Label("Other methods", systemImage: "arrow.backward.circle")
        .fontWeight(.medium)
        .foregroundStyle(.csCream)
        .onTapGesture { selectedMethod = .none }
    }
    .fullScreenCover(isPresented: $isShownHome) {
      EntryPoint()
    }
  }
  
  private var signInButton: some View {
    Button {
      Task {
        await authViewModel.signIn(with: emailAddress, and: password)
        isShownHome.toggle()
      }
    } label: {
      ButtonLabel("Sign In", textColor: .white, pouring: .black)
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.5 : 1)
  }
}

#Preview {
  EmailAndPasswordForm(.constant(.emailAndPassword))
    .environmentObject(AuthenticationViewModel())
}
