//
//  PasswordRecoveryForm.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct PasswordRecoveryForm: View {
  
  @State private var emailAddress = ""
  @State private var showAlert = false
  @State private var alertTitle = ""
  @State private var alertMessage = ""
  @FocusState private var isEmailFocused: Bool
  
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidEmail: Bool {
    authViewModel.isValidEmail(emailAddress)
  }
  
  var body: some View {
    VStack(spacing: 20) {
      Text("Password Recovery")
        .font(.title2)
        .fontWeight(.bold)
        .foregroundStyle(.white)
      
      Text("Enter your email address and we'll send you a link to reset your password.")
        .font(.footnote)
        .multilineTextAlignment(.center)
        .foregroundStyle(.gray)
        .padding(.horizontal)
      
      List {
        DefaultTextField(for: .emailAddress, inputData: $emailAddress)
          .focused($isEmailFocused)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.done)
          .onSubmit { isEmailFocused = false }
      }
      .frame(height: 90)
      .environment(\.defaultMinListRowHeight, 50)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      Button {
        Task {
          await sendPasswordResetEmail()
        }
      } label: {
        ButtonLabel(
          "Send Recovery Link",
          textColor: .csCream,
          pouring: .black
        )
      }
      .disabled(!isValidEmail)
      .opacity(!isValidEmail ? 0.5 : 1)
    }
    .alert(alertTitle, isPresented: $showAlert) {
      Button("Back to Sign In") {
        dismiss()
      }
    } message: {
      Text(alertMessage)
    }
  }
  
  private func sendPasswordResetEmail() async {
    do {
      try await authViewModel.resetPassword(for: emailAddress)
      alertTitle = "Success"
      alertMessage = "A password reset link has been sent to your email address"
//      isSuccess = true
    } catch {
      alertTitle = "Error"
      alertMessage = "Failed to send password reset email. Please try again."
//      isSuccess = false
    }
    showAlert = true
  }
}

#Preview {
  PasswordRecoveryForm()
    .environmentObject(AuthViewModel())
} 
