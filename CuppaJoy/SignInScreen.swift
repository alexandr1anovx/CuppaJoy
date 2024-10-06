//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var email = ""
    @State private var password = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.cream.ignoresSafeArea()
                
                VStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 50) {
                        
                        HeaderLabels()
                        
                        VStack(spacing: 25) {
                            CustomTextField(
                                imageName: "envelope",
                                placeholder: "Email address",
                                inputData: $email
                            )
                            CustomTextField(
                                imageName: "lock.rectangle",
                                placeholder: "Password",
                                inputData: $password
                            )
                        }
                    }
                    .padding(.horizontal, 40)
                    
                    Button("Forgot Password?") {
                        
                    }
                    .font(.poppins(.medium, size: 13))
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
                            .font(.poppins(.regular, size: 15))
                            .foregroundStyle(.hotGray)
                        
                        NavigationLink("Sign Up") {
                            // SignUpScreen()
                        }
                        .font(.poppins(.medium, size: 16))
                        .foregroundStyle(.darkBrown)
                        Spacer()
                    }
                    .padding(30)
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 20))
                                .foregroundStyle(.darkBrown)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    SignInScreen()
}

struct HeaderLabels: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Sign In")
                .font(.poppins(.medium, size: 23))
                .foregroundStyle(.darkBrown)
            
            Text("Welcome back!")
                .font(.poppins(.regular, size: 15))
                .foregroundStyle(.hotGray)
        }
    }
}
