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
        Color.appBackground.ignoresSafeArea(.all)
        
        VStack(alignment: .center, spacing:0) {
          AuthHeaderView(
            title: "Sign In.",
            subtitle: "Welcome to Cuppa Joy."
          )
          textFieldList
          signInButton.padding(.top,30)
          signUpOption.padding(23)
        }
      }
    }
  }
  
  // MARK: - Text Field list
  private var textFieldList: some View {
    List {
      CustomTextField(
        imageName: "phone",
        placeholder: "Your phone number",
        inputData: $phoneNumber
      )
    }
    .frame(height: 85)
    .scrollContentBackground(.hidden)
    .scrollIndicators(.hidden)
    .scrollDisabled(true)
  }
  
  // MARK: - Sign In button
  private var signInButton: some View {
    Button {
      // logic
    } label: {
      Text("Sign In")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(.white)
        .padding(.vertical,8)
        .padding(.horizontal,140)
    }
    .tint(Color.csBrown)
    .buttonStyle(.borderedProminent)
    .shadow(radius: 5)
  }
  
  // MARK: - Sign Up option
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
          .foregroundStyle(.csDesert)
      }
    }
    .shadow(radius: 5)
  }
}

#Preview {
  SignInScreen()
}
