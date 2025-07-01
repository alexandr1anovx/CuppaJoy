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
  @StateObject var viewModel: LoginViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackgroundDimmed.ignoresSafeArea()
        VStack(spacing:25) {
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
        RegistrationScreen()
      } label: {
        Text("Sign Up.")
          .font(.subheadline)
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
      }
    }
  }
}
