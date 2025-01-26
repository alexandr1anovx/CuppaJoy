//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
  
  @State private var phoneNumber = ""
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.mainGradientBackground.ignoresSafeArea()

        VStack(alignment: .leading, spacing: 30) {
          AuthHeaderView(title: "Sign In", subtitle: "Welcome back.")

          CustomTextField(
            image: .mobile,
            placeholder: "phone number",
            inputData: $phoneNumber
          )
          HStack {
            signUpButton
            Spacer()
            nextButton
          }
        }
        .padding(.horizontal, 20)
      }
    }
  }
  
  // MARK: - Next Button
  private var nextButton: some View {
    Button {
      // action
    } label: {
      Text("Next")
        .font(.poppins(.bold, size: 14))
        .foregroundStyle(.white)
        .padding(5)
    }
    .buttonStyle(.borderedProminent)
    .tint(.black)
  }
  
  // MARK: - Sign Up Option
  private var signUpButton: some View {
    HStack(spacing: 5) {
      Text("New member?")
        .font(.callout)
        .fontDesign(.rounded)
        .foregroundStyle(.gray)
      
      NavigationLink {
        SignUpScreen()
      } label: {
        Text("Sign Up")
          .font(.callout)
          .fontWeight(.bold)
          .fontDesign(.rounded)
          .foregroundStyle(.accent)
      }
    }
  }
}

#Preview {
  SignInScreen()
}
