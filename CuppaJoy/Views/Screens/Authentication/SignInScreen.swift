//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

enum SignInMethod {
  case emailWithLink
  case emailWithPassword
  case phoneNumber
}

struct SignInScreen: View {
  
  // MARK: Properties
  @State private var phoneNumber = ""
  @State private var emailAddress = ""
  @State private var password = ""
  @State private var selectedSignInMethod: SignInMethod?
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          AuthHeaderView(for: .signIn)
          pageContent
        }
      }
    }
  }
  
  // MARK: Page Content
  @ViewBuilder
  private var pageContent: some View {
    if selectedSignInMethod == nil {
      authMethodsView
    } else if selectedSignInMethod == .emailWithLink {
      emailLinkForm
    } else if selectedSignInMethod == .emailWithPassword {
      emailPasswordForm
    } else {
      phoneNumberForm
    }
  }
  
  // MARK: View "Authentication Methods"
  private var authMethodsView: some View {
    VStack(spacing: 15) {
      emailWithLinkButton
      emailWithPasswordButton
      phoneNumberButton
      signUpOption
    }.padding(.top, 30)
  }
  
  // MARK: - Form "SignIn with email and password"
  private var emailPasswordForm: some View {
    VStack(spacing: 20) {
      List {
        CSTextField(for: .emailAddress, inputData: $emailAddress)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.send)
          .onSubmit {
            // action
          }
        CSTextField(for: .password, inputData: $password, isSecure: true)
          .textContentType(.password)
      }
      .frame(height: 135)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      signInButton
        .disabled(!authViewModel.isValidEmail(emailAddress) && password.count >= 8)
      
      Label("Other methods", systemImage: "arrow.backward.circle")
        .fontWeight(.medium)
        .foregroundStyle(.orange)
        .onTapGesture { selectedSignInMethod = .none }
    }
  }
  
  // MARK: - Form "SignIn with email link"
  private var emailLinkForm: some View {
    VStack(spacing: 20) {
      List {
        CSTextField(for: .emailAddress, inputData: $emailAddress)
          .keyboardType(.emailAddress)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .submitLabel(.send)
          .onSubmit {
            // action
          }
      }
      .frame(height: 85)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      signInButton
        .disabled(!authViewModel.isValidEmail(emailAddress))
      
      Label("Other methods", systemImage: "arrow.backward.circle")
        .fontWeight(.medium)
        .foregroundStyle(.orange)
        .onTapGesture { selectedSignInMethod = .none }
    }
  }
  
  // MARK: - Form "SignIn with phone number"
  private var phoneNumberForm: some View {
    VStack(spacing: 20) {
      List {
        CSTextField(for: .phoneNumber, inputData: $phoneNumber)
          .submitLabel(.done)
      }
      .frame(height: 85)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      signInButton
        .disabled(!authViewModel.isValidPhoneNumber(phoneNumber))
      
      Label("Other methods", systemImage: "arrow.backward.circle")
        .fontWeight(.medium)
        .foregroundStyle(.orange)
        .onTapGesture { selectedSignInMethod = .none }
    }
  }
  
  // MARK: - Button "SignIn with email link"
  private var emailWithLinkButton: some View {
    Button {
      selectedSignInMethod = .emailWithLink
    } label: {
      ButtonLabelWithIcon(
        "Continue with Email (link)",
        icon: "envelope",
        textColor: .csCream,
        pouring: .black
      )
    }
  }
  
  // MARK: - Button "SignIn with email and password"
  private var emailWithPasswordButton: some View {
    Button {
      selectedSignInMethod = .emailWithPassword
    } label: {
      ButtonLabelWithIcon(
        "Continue with Email (password)",
        icon: "envelope",
        textColor: .csCream,
        pouring: .black
      )
    }
  }
  
  // MARK: Button "SignIn with phone number"
  private var phoneNumberButton: some View {
    Button {
      selectedSignInMethod = .phoneNumber
    } label: {
      ButtonLabelWithIcon(
        "Continue with Phone",
        icon: "phone",
        textColor: .csCream,
        pouring: .black
      )
    }
  }
  
  // MARK: Default Button "SignIn"
  private var signInButton: some View {
    Button {
      // sign in action
    } label: {
      ButtonLabel("Sign In", textColor: .white, pouring: .black)
    }
  }
  
  // MARK: Option "New member? SignUp"
  private var signUpOption: some View {
    HStack(spacing: 5) {
      Text("New member?")
        .font(.footnote)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up.")
          .font(.callout)
          .fontWeight(.bold)
          .foregroundStyle(.orange)
      }
    }
  }
}

#Preview {
  SignInScreen()
    .environmentObject(AuthenticationViewModel())
}
