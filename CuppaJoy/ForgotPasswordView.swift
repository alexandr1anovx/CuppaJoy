//
//  ForgotPasswordView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.10.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var email = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 50) {
                HeaderLabels(
                    title: "Forgot Password?",
                    subtitle: "Enter your email address"
                )
                CustomTextField(
                    imageName: "message",
                    placeholder: "Email address",
                    inputData: $email
                )
                
                NavigationLink {
                    // Verification Screen
                } label: {
                    Spacer()
                    NextStepView()
                }
                Spacer()
            }
            .padding(.top, 40)
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
    ForgotPasswordView()
}
