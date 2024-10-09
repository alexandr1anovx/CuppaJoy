//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct SignUpScreen: View {
    
    @State private var initials = ""
    @State private var mobileNumber = ""
    @State private var emailAddress = ""
    @State private var password = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                HeaderLabels(
                    title: "Sign Up",
                    subtitle: "Create an account here"
                )
                VStack(spacing: 36) {
                    CustomTextField(
                        imageName: "person",
                        placeholder: "Your name and surname",
                        inputData: $initials
                    )
                    
                    CustomTextField(
                        imageName: "smartphone",
                        placeholder: "Mobile Number",
                        inputData: $mobileNumber
                    )
                    
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
                .padding(.top, 45)
                
                Text("By signing up you agree with our Terms of Use")
                    .font(.poppins(.regular, size: 13))
                    .foregroundStyle(.middleBrown)
                    .padding(.top, 25)
                
                Spacer()
                
                NavigationLink {
                    // Code Confirmation View
                } label: {
                    Spacer()
                    NextStepView()
                }
                .padding(.trailing, 20)
                
                Spacer()
                
                HStack(spacing: 5) {
                    Text("Already a member?")
                        .font(.poppins(.regular, size: 14))
                        .foregroundStyle(.hotGray)
                    
                    NavigationLink("Sign In") {
                        // SignUpScreen()
                    }
                    .font(.poppins(.medium, size: 14))
                    .foregroundStyle(.darkBrown)
                }
                .padding(.bottom, 20)
            }
            .padding(.horizontal, 40)
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

#Preview {
    SignUpScreen()
}
