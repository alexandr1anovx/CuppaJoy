//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var isPresentedHomeScreen: Bool = false
    @State private var isPresentedSignUpScreen: Bool = false
    @State private var phoneNumber: String = ""
    
    var body: some View {
        Group {
            if isPresentedHomeScreen {
                HomeScreen()
            } else {
                ZStack {
                    Color.customSystem.ignoresSafeArea()
                    
                    // MARK: - Main VStack
                    VStack(alignment: .leading, spacing: 35) {
                        HeaderLabels(
                            title: "Sign In",
                            subtitle: "Welcome back!"
                        )
                        CustomTextField(
                            imageName: "smartphone",
                            placeholder: "Phone Number",
                            inputData: $phoneNumber
                        )
                        
                        HStack {
                            Spacer()
                            
                            BorderedButton(
                                title: "Next",
                                imageName: "arrow.right") {
                                    withAnimation(.smooth(duration: 0.6)) {
                                        isPresentedHomeScreen.toggle()
                                    }
                                }
                        }
                        
                        HStack(spacing: 5) {
                            Text("New member?")
                                .font(.poppins(.regular, size: 14))
                                .foregroundStyle(.customReversed)
                                .opacity(0.6)
                            
                            Button("Sign Up") {
                                isPresentedSignUpScreen.toggle()
                            }
                            .font(.poppins(.medium, size: 14))
                            .foregroundStyle(.customReversed)
                        }
                    }
                    .padding(.horizontal, 40)
                    .sheet(isPresented: $isPresentedSignUpScreen) {
                        SignUpScreen()
                            .presentationDetents([.large])
                            .presentationDragIndicator(.visible)
                            .presentationCornerRadius(20)
                    }
                }
            }
        }
    }
}

#Preview {
    SignInScreen()
}
