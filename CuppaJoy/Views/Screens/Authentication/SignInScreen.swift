//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

enum SignInMethod {
  case emailAndPassword
  case emailLink
  case phoneNumber
}

struct SignInScreen: View {
  
  @State private var selectedMethod: SignInMethod?
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
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
    if selectedMethod == nil {
      authMethodsView
    } else if selectedMethod == .emailAndPassword {
      EmailAndPasswordForm($selectedMethod)
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
      selectedMethod = .emailAndPassword
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
      Text("New member?")
        .font(.footnote)
        .fontWeight(.medium)
        .foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up.")
          .font(.callout)
          .fontWeight(.bold)
          .foregroundStyle(.csCream)
      }
    }
  }
}

#Preview {
  SignInScreen()
    .environmentObject(AuthenticationViewModel())
}
