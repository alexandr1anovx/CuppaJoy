//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

enum SignInMethod {
  case email, phone
}

struct SignInScreen: View {
  
  // MARK: Properties
  @State private var phoneNumber = ""
  @State private var emailAddress = ""
  @State private var selectedMethod: SignInMethod?
  @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
  
  private var isValidForm: Bool {
    authenticationViewModel.isValidPhoneNumber(phoneNumber)
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          AuthHeaderView(authAction: .signIn)
          content
        }
      }
    }
  }
  
  // MARK: Shown Content
  @ViewBuilder
  private var content: some View {
    if selectedMethod == nil {
      authMethodsView
    } else if selectedMethod == .email {
      emailForm
    } else {
      phoneNumberForm
    }
  }
  
  private var authMethodsView: some View {
    VStack(spacing: 15) {
      signInWithEmailButton
      signInWithPhoneNumberButton
      signUpOption
    }
    .padding(.top, 30)
  }
  
  private var emailForm: some View {
    VStack(spacing: 20) {
      List {
        CSTextField(
          icon: "envelope",
          hint: "Email address",
          inputData: $emailAddress
        )
        .keyboardType(.emailAddress)
        .textInputAutocapitalization(.never)
        .autocorrectionDisabled(true)
        .submitLabel(.send)
        .onSubmit {
          // call a "signInWithEmailLink" method
        }
      }
      .frame(height: 85)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      signInButton
      
      Label("Other methods", systemImage: "arrow.backward.circle")
        .fontWeight(.medium)
        .foregroundStyle(.orange)
        .onTapGesture { selectedMethod = .none }
    }
  }
  
  private var phoneNumberForm: some View {
    VStack(spacing: 20) {
      List {
        CSTextField(
          icon: "phone",
          hint: "Phone number",
          inputData: $phoneNumber
        )
        .submitLabel(.done)
      }
      .frame(height: 85)
      .scrollContentBackground(.hidden)
      .scrollIndicators(.hidden)
      .scrollDisabled(true)
      
      signInButton
      
      Label("Other methods", systemImage: "arrow.backward.circle")
        .fontWeight(.medium)
        .foregroundStyle(.orange)
        .onTapGesture { selectedMethod = .none }
    }
  }
  
  // MARK: "Sign In with email" button
  private var signInWithEmailButton: some View {
    Button {
      selectedMethod = .email
    } label: {
      ButtonLabelWithIcon(
        "Continue with Email",
        icon: "envelope",
        textColor: .csCream,
        pouring: .black
      )
    }
  }
  
  // MARK: "Sign In with phone number" button
  private var signInWithPhoneNumberButton: some View {
    Button {
      selectedMethod = .phone
    } label: {
      ButtonLabelWithIcon(
        "Continue with Phone",
        icon: "phone",
        textColor: .csCream,
        pouring: .black
      )
    }
  }
  
  // MARK: General "Sign In" button
  private var signInButton: some View {
    Button {
      // sign in action
    } label: {
      ButtonLabel("Sign In", textColor: .white, pouring: .black)
    }
    .disabled(!isValidForm)
  }
  
  // MARK: "Sign Up" option
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
