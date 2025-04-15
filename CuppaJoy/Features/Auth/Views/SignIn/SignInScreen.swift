//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.csBlack.ignoresSafeArea(.all)
        VStack(spacing: 25) {
          // Sign In Header View
          HStack(alignment: .firstTextBaseline) {
            Text("Sign In.")
              .font(.title3)
              .fontWeight(.bold)
              .foregroundStyle(.csCream)
            Text("Select a convenient way.")
              .font(.headline)
              .fontWeight(.medium)
              .foregroundStyle(.gray)
          }
          emailAndPasswordButton
          signUpButton
        }
      }
    }
  }
  
  private var emailAndPasswordButton: some View {
    NavigationLink {
      EmailAndPasswordForm()
    } label: {
      ButtonLabelWithIcon(
        "Continue with Email & Password",
        icon: "envelope",
        textColor: .orange,
        bgColor: .black
      )
    }
  }
  
  private var signUpButton: some View {
    HStack(spacing: 5) {
      Text("Don't have an account?")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up.")
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
      }
    }
  }
}

#Preview {
  SignInScreen()
    .environmentObject(AuthViewModel.previewMode())
}
