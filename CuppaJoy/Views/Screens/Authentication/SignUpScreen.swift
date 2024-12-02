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
                Color.cstDarkBrown.ignoresSafeArea()
                
                VStack(alignment: .leading, spacing: 30) {
                    TitleView(
                        "Sign Up",
                        subtitle: "Create an account here."
                    )
                    
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
                            .foregroundStyle(.cstGray)
                        Button("Sign In") {
                            dismiss()
                        }
                        .font(.poppins(.medium, size: 15))
                        .foregroundStyle(.cstMint)
                    }
                }
                .padding(.horizontal, 30)
                .sheet(isPresented: $isShownSMSConfirmation) {
                    SMSConfirmationView()
                        .presentationDetents([.medium])
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
                image: "user",
                placeholder: "Name and surname",
                inputData: $initials
            )
            CustomTextField(
                image: "phone",
                placeholder: "Phone Number",
                inputData: $phoneNumber
            )
        }
    }
}

#Preview {
    SignUpScreen()
}
