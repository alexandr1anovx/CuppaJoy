//
//  PasswordRecoveryForm.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.03.2025.
//

import SwiftUI

struct PasswordRecoveryScreen: View {
  
  @State private var email = ""
  @EnvironmentObject var authViewModel: AuthViewModel
  private let validationService = ValidationService.shared
  
  var body: some View {
    ZStack {
      Color.appBackgroundDimmed.ignoresSafeArea()
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
          InputField(for: .email, data: $email)
            .keyboardType(.emailAddress)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .submitLabel(.done)
        }
        .customListStyle()
        .frame(height: 90)
        .environment(\.defaultMinListRowHeight, 50)
        
        Button {
          Task {
            await authViewModel.sendPasswordResetLink(to: email)
          }
        } label: {
          ButtonLabel(
            "Send Recovery Link",
            textColor: .csCream,
            bgColor: .black
          )
        }
        .disabled(!validationService.isValid(email: email))
        .opacity(!validationService.isValid(email: email) ? 0.5 : 1)
      }
    }
    .alert(item: $authViewModel.alertItem) { alertItem in
      Alert(
        title: alertItem.title,
        message: alertItem.message,
        dismissButton: alertItem.dismissButton
      )
    }
  }
}

#Preview {
  PasswordRecoveryScreen()
    .environmentObject(AuthViewModel.previewMode)
}
