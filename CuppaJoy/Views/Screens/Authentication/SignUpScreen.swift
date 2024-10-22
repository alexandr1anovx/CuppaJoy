//
//  SignUpScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

struct SignUpScreen: View {
    
    @State private var isShownVerification: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.primarySystem.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 40) {
                HeaderLabel(
                    title: "Sign Up",
                    subtitle: "Create an account here."
                )
                
                TextFieldsForm()
                
                HStack {
                    Spacer()
                    
                    Button {
                        isShownVerification.toggle()
                    } label: {
                        BorderedLabel(title: "Sign Up", imageName: "checkmark")
                    }
                }
                
                HStack(spacing: 5) {
                    Text("Already a member?")
                        .font(.poppins(.regular, size: 13))
                        .foregroundStyle(.primaryGray)
                    Button("Sign In") {
                        dismiss()
                    }
                    .font(.poppins(.medium, size: 15))
                    .foregroundStyle(.primaryMint)
                }
                
                Spacer()
                
            }
            .padding(.top, 40)
            .padding(.horizontal, 30)
            .sheet(isPresented: $isShownVerification) {
                SMSVerificationScreen()
                    .presentationDetents([.medium])
                    .presentationCornerRadius(25)
                    .presentationDragIndicator(.visible)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        BackButton()
                    }
                }
            }
        }
    }
}

#Preview {
    SignUpScreen()
}

struct TextFieldsForm: View {
    
    @State private var initials: String = ""
    @State private var phoneNumber: String = ""
    @State private var email: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            CustomTextField(
                imageName: "person",
                placeholder: "Name and surname",
                inputData: $initials
            )
            CustomTextField(
                imageName: "iphone.gen3",
                placeholder: "Phone Number",
                inputData: $phoneNumber
            )
        }
    }
}
