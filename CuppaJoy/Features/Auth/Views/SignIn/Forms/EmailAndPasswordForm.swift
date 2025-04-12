//
//  SignInWithEmailPasswordForm.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct EmailAndPasswordForm: View {
  
  @State private var email = ""
  @State private var password = ""
  @State private var isShownHome = false
  @State private var isShownPasswordRecoveryView = false
  @FocusState private var inputContent: InputContentType?
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidForm: Bool {
    authViewModel.isValidEmail(email)
    && authViewModel.isValidPassword(password)
  }
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      VStack(spacing: 20) {
        List {
          Section {
            InputField(for: .email, data: $email)
              .focused($inputContent, equals: .email)
              .keyboardType(.emailAddress)
              .textInputAutocapitalization(.never)
              .autocorrectionDisabled(true)
              .submitLabel(.next)
              .onSubmit { inputContent = .password }
            SecuredInputField(password: $password)
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
        .frame(height: 160)
        .shadow(radius: 1)
        .environment(\.defaultMinListRowHeight, 53)
        .scrollContentBackground(.hidden)
        .scrollIndicators(.hidden)
        .scrollDisabled(true)
        
        signInButton
        
        forgotPasswordButton
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.leading, 25)
      }
      .frame(maxHeight: .infinity, alignment: .top)
      .navigationTitle("Sign In")
      .navigationBarBackButtonHidden(true)
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          Button {
            dismiss()
          } label: {
            ButtonLabelReturn()
          }
        }
      }
      .fullScreenCover(isPresented: $isShownHome) {
        EntryPoint()
      }
      .sheet(isPresented: $isShownPasswordRecoveryView) {
        PasswordRecoveryScreen()
          .presentationCornerRadius(30)
          .presentationDragIndicator(.visible)
      }
    }
  }
  
  private var signInButton: some View {
    Button {
      Task {
        await authViewModel.signIn(with: email, and: password)
        isShownHome.toggle()
      }
    } label: {
      ButtonLabel(
        "Sign In",
        textColor: .orange,
        bgColor: .black
      )
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
  
  private var forgotPasswordButton: some View {
    Button {
      isShownPasswordRecoveryView.toggle()
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
  EmailAndPasswordForm()
    .environmentObject(AuthViewModel.previewMode())
}
