//
//  SignInWithEmailPasswordForm.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct LoginFormEmailAndPassword: View {
  
  @State var viewModel: LoginViewModel
  @FocusState private var inputContent: InputContentType?
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
      VStack(spacing: 15) {
        Form {
          Section {
            InputField(for: .email, data: $viewModel.email)
              .focused($inputContent, equals: .email)
              .keyboardType(.emailAddress)
              .textInputAutocapitalization(.never)
              .autocorrectionDisabled(true)
              .submitLabel(.next)
              .onSubmit { inputContent = .password }
            SecuredInputField(password: $viewModel.password)
              .focused($inputContent, equals: .password)
              .submitLabel(.done)
              .onSubmit { inputContent = nil }
          } header: {
            Text("Enter your email and password")
              .font(.caption)
              .fontWeight(.semibold)
              .padding(.bottom, 10)
          }
        }
        .customListStyle(minRowHeight: 50, rowSpacing: 8, scrollDisabled: true, height: 165, shadow: 5)
        
        signInButton
        
        forgotPasswordButton
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 25)
      }
      .frame(maxHeight: .infinity, alignment: .top)
      .navigationTitle("Login")
      .navigationBarBackButtonHidden(true)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            dismiss()
          } label: {
            ReturnButtonLabel()
          }
        }
      }
      .sheet(isPresented: $viewModel.showPasswordRecoveryView) {
        PasswordRecoveryScreen()
          .presentationCornerRadius(30)
          .presentationDragIndicator(.visible)
      }
    }
  }
  
  // MARK: - Subviews
  
  private var signInButton: some View {
    Button {
      Task { await viewModel.signIn() }
    } label: {
      ButtonLabel("Sign In", textColor: .white, bgColor: .black)
    }
    .disabled(!viewModel.isValidForm)
    .opacity(!viewModel.isValidForm ? 0.3 : 1)
    .alert(item: $viewModel.alert) { alert in
      Alert(
        title: alert.title,
        message: alert.message,
        dismissButton: alert.dismissButton
      )
    }
  }
  
  private var forgotPasswordButton: some View {
    Button {
      viewModel.showPasswordRecoveryView.toggle()
    } label: {
      Text("Forgot password?")
        .font(.caption)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
        .underline()
    }
  }
}
