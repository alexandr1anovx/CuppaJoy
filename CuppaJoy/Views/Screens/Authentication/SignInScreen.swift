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
          signInButton.padding(.top, 30)
          signUpOption.padding(25)
        }
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
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 130)
    }
    .buttonStyle(.borderedProminent)
    .tint(.csDesert)
    .shadow(radius: 8)
    .disabled(!isValidForm)
  }
  
  // MARK: Sign Up option
  private var signUpOption: some View {
    HStack(spacing: 5) {
      Text("New member?")
        .font(.poppins(.regular, size: 13))
        .foregroundStyle(.gray)
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up")
          .font(.poppins(.bold, size: 15))
          .foregroundStyle(.white)
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
