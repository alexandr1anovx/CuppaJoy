//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct SignUpScreen: View {
    
    @State private var isShownSMSConfirmation = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.primaryBrown.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 40) {
                    HeaderView(title: "Sign Up",
                               subtitle: "Create an account here.")
                    
                    SignUpForm()
                    
                    HStack {
                        Spacer()
                        MainButton("Sign Up") {
                            isShownSMSConfirmation.toggle()
                        }
                    }
                    
                    HStack(spacing: 5) {
                        Text("Already a member?")
                            .font(.poppins(.regular, size: 13))
                            .foregroundStyle(.primaryWhite)
                        Button("Sign In") {
                            dismiss()
                        }
                        .font(.poppins(.medium, size: 15))
                        .foregroundStyle(.primaryMint)
                    }
                }
                .padding(.horizontal, 30)
                
                .sheet(isPresented: $isShownSMSConfirmation) {
                    SMSConfirmationView()
                        .presentationDetents([.height(290)])
                        .presentationCornerRadius(20)
                        .presentationDragIndicator(.visible)
                }
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        BackButton()
                    }
                }
            }
        }
    }
}

struct SignUpForm: View {
    @State private var initials = ""
    @State private var phoneNumber = ""
    @State private var email = ""
    
    var body: some View {
        VStack(spacing: 25) {
            CustomTextField(
                imageName: "user",
                placeholder: "Name and surname",
                inputData: $initials
            )
            CustomTextField(
                imageName: "phone",
                placeholder: "Phone Number",
                inputData: $phoneNumber
            )
        }
    }
}

#if DEBUG
#Preview { SignUpScreen() }
#endif
