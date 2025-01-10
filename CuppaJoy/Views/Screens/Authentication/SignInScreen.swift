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
        Color.mainBackgroundGradient.ignoresSafeArea()
        
        VStack(alignment: .leading, spacing: 30) {
          AuthHeaderView(title: "Sign In", subtitle: "Welcome back.")
          
          CustomTextField(
            image: "phone",
            placeholder: "Phone Number",
            inputData: $phoneNumber
          )
          HStack {
            Spacer()
            Button {
              /*
               + show the "Home" screen if credentials are correct
               - show an alert with the error description
               */
            } label: {
              Text("Next")
                .font(.poppins(.bold, size: 15))
                .foregroundStyle(.cstCream)
                .padding(5)
            }
            .buttonStyle(.bordered)
            .tint(.cstCream)
          }
          HStack(spacing: 5) {
            Text("New member?")
              .font(.poppins(.regular, size: 14))
              .foregroundStyle(.cstGray)
            
            NavigationLink {
              SignUpScreen()
            } label: {
              Text("Sign Up")
                .font(.poppins(.bold, size: 15))
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
