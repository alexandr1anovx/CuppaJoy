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
  @Binding var signInMethod: SignInMethod?
  @FocusState private var fieldContent: TextFieldInputType?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidForm: Bool {
    authViewModel.isValidEmail(emailAddress)
    && authViewModel.isValidPassword(password)
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
      .shadow(radius: 1)
      .environment(\.defaultMinListRowHeight, 50)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      HStack(spacing:0) {
        passwordRecoveryButton
        Spacer()
      }.padding(.leading,25)
      
      signInButton
      
      Label("Back to other methods", systemImage: "arrow.backward.circle.fill")
        .font(.subheadline)
        .fontWeight(.medium)
        .foregroundStyle(.csCream)
        .onTapGesture { signInMethod = nil }
        .padding(.top, 10)
    }
  }
  
  private var signInButton: some View {
    Button {
      Task {
        await authViewModel.signIn(
          with: emailAddress,
          and: password
        )
      }
    } label: {
      ButtonLabel("Sign In", textColor: .white, pouring: .black)
    }
    .disabled(!isValidForm)
    .opacity(!isValidForm ? 0.5 : 1)
    .alert(item: $authViewModel.alertItem) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var passwordRecoveryButton: some View {
    NavigationLink {
      PasswordRecoveryScreen()
    } label: {
      Text("Forgot password?")
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
        .underline(true)
    }
  }
}

#Preview {
  EmailAndPasswordForm(signInMethod: .constant(.emailAndPassword))
    .environmentObject( AuthViewModel() )
}
