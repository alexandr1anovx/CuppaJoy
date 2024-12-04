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
        Color.cstDarkBrown.ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: 30) {
          // Header
          VStack(alignment: .leading, spacing: 15) {
            Text("Sign In")
              .foregroundStyle(.cstCream)
              .font(.poppins(.medium, size: 20))
            Text("Welcome back.")
              .font(.poppins(.regular, size: 14))
              .foregroundStyle(.cstGray)
          }
          
          CustomTextField(
            image: "phone",
            placeholder: "Phone Number",
            inputData: $phoneNumber
          )
          HStack {
            Spacer()
            CustomBtn("Next") {
              /*
               + show the Home screen if credentials are correct
               - show an alert with the error description
               */
            }
          }
          HStack(spacing: 5) {
            Text("New member?")
              .font(.poppins(.regular, size: 14))
              .foregroundStyle(.cstGray)
            
            NavigationLink {
              SignUpScreen()
            } label: {
              Text("Sign Up")
                .font(.poppins(.medium, size: 14))
                .foregroundStyle(.cstCream)
            }
          }
        }
        .padding(.horizontal, 30)
      }
    }
  }
}

#Preview {
  SignInScreen()
}
