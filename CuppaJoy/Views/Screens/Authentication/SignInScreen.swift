//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
  
  // Stored Properties
  @State private var phoneNumber = ""
  
  // Computed Properties
  private var isValidForm: Bool {
    isValidPhoneNumber(phoneNumber)
  }
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.appBackground.ignoresSafeArea(.all)
        VStack(spacing: 0) {
          AuthHeaderView(
            title: "Sign In.",
            subtitle: "Welcome to Cuppa Joy."
          )
          textFieldList
          signInButton.padding(.top, 25)
          signUpOption.padding(.top, 20)
        }
        .padding(.horizontal, 10)
      }
    }
  }
  
  // MARK: Text Field list
  private var textFieldList: some View {
    List {
      CSTextField(
        icon: "phone",
        prompt: "Your phone number",
        inputData: $phoneNumber
      )
      .submitLabel(.done)
    }
    .frame(height: 85)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
    .shadow(radius: 8)
  }
  
  // MARK: Sign In button
  private var signInButton: some View {
    Button {
      // logic
    } label: {
      Text("Sign In")
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    .buttonStyle(.borderedProminent)
    .tint(.csBrown)
    .padding(.horizontal, 20)
    .shadow(radius: 8)
    .disabled(!isValidForm)
  }
  
  // MARK: Sign Up option
  private var signUpOption: some View {
    HStack(spacing: 8) {
      Text("New member?")
        .font(.footnote)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up.")
          .font(.callout).bold()
          .fontDesign(.monospaced)
          .font(.poppins(.bold, size: 15))
          .foregroundStyle(.csCream)
      }
    }
    .shadow(radius: 8)
  }
  
  private func isValidPhoneNumber(_ phone: String) -> Bool {
    let regex = #"^(\+380|0)\d{9}$"#
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: phoneNumber)
  }
}

#Preview {
  SignInScreen()
}
