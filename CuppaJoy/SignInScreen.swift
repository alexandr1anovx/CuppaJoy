//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var emailAddress = ""
    @State private var password = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 50) {
                    HeaderLabels(
                        title: "Sign In",
                        subtitle: "Welcome back!"
                    )
                    
                    VStack(spacing: 25) {
                        CustomTextField(
                            imageName: "message",
                            placeholder: "Email address",
                            inputData: $emailAddress
                        )
                        CustomTextField(
                            imageName: "lock",
                            placeholder: "Password",
                            inputData: $password
                        )
                    }
                }
                
                Button("Forgot Password?") {
                    
                }
                .font(.poppins(.medium, size: 14))
                .foregroundStyle(.middleBrown)
                .padding(.top, 20)
                
                Spacer()
                
                NavigationLink {
                    // MainScreen()
                } label: {
                    Spacer()
                    NextStepView()
                }
                .padding(.trailing, 20)
                
                Spacer()
                
                HStack(spacing: 5) {
                    Text("New member?")
                        .font(.poppins(.regular, size: 14))
                        .foregroundStyle(.hotGray)
                    
                    NavigationLink("Sign Up") {
                        SignUpScreen()
                    }
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.darkBrown)
                    
                    Spacer()
                }
                .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal, 40)
        }
    }
}


#Preview {
    SignInScreen()
}
