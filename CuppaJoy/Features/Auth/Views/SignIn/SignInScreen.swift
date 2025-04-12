//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.csBlack.ignoresSafeArea(.all)
        VStack(spacing: 25) {
          AuthHeaderView(for: .signIn)
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
      Text("Don't have an account yet?")
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
    .environmentObject(AuthViewModel())
}
