//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct LoginScreen: View {
  
  let authService: AuthServiceProtocol
  let userService: UserServiceProtocol
  @State var viewModel: LoginViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackgroundDimmed.ignoresSafeArea()
        VStack(spacing:25) {
          Text("Login")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.csCream)
          emailAndPasswordButton
          signUpButton
        }
      }
    }
  }
  
  // MARK: - Subviews
  
  private var emailAndPasswordButton: some View {
    NavigationLink {
      LoginFormEmailAndPassword(viewModel: viewModel)
    } label: {
      ButtonLabelWithIcon(
        "Continue with Email & Password",
        icon: "envelope",
        textColor: .white,
        bgColor: .black
      )
    }
  }
  
  private var signUpButton: some View {
    HStack(spacing:5) {
      Text("Don't have an account?")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      NavigationLink {
        RegistrationScreen(
          viewModel: RegistrationViewModel(
            authService: authService,
            userService: userService
          )
        )
      } label: {
        Text("Sign Up.")
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
      }
    }
  }
}
