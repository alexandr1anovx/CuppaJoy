//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

enum SignInMethod {
  case emailAndPassword
  // Add more in the future
}

struct SignInScreen: View {
  
  @State private var signInMethod: SignInMethod?
  @EnvironmentObject var authViewModel: AuthViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.csBlack.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          AuthHeaderView(for: .signIn)
          pageContent
        }
      }
    }
  }
  
  @ViewBuilder
  private var pageContent: some View {
    if signInMethod == nil {
      authMethodsView
    } else if signInMethod == .emailAndPassword {
      EmailAndPasswordForm(signInMethod: $signInMethod)
    }
  }
  
  private var authMethodsView: some View {
    VStack(spacing: 15) {
      continueWithEmailAndPasswordButton
      signUpButton
    }.padding(.top, 30)
  }
  
  private var continueWithEmailAndPasswordButton: some View {
    Button {
      signInMethod = .emailAndPassword
    } label: {
      ButtonLabelWithIcon(
        "Continue with Email & Password",
        icon: "envelope",
        textColor: .orange,
        pouring: .black
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
