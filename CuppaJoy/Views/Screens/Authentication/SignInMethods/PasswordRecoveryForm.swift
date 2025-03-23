//
//  PasswordRecoveryForm.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct PasswordRecoveryForm: View {
  
  @State private var emailAddress = ""
  @FocusState private var isEmailFocused: Bool
  @EnvironmentObject var authViewModel: AuthViewModel
  
  private var isValidEmail: Bool {
    authViewModel.isValidEmail(emailAddress)
  }
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(edges: .all)
      
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
            await authViewModel.sendPasswordResetLink(to: emailAddress)
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
        .alert(item: $authViewModel.alertItem) { alertItem in
          Alert(
            title: alertItem.title,
            message: alertItem.message,
            dismissButton: alertItem.dismissButton
          )
        }
      }
    }
  }
}

#Preview {
  PasswordRecoveryForm()
    .environmentObject(AuthViewModel())
}
