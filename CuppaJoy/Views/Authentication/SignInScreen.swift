//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
    
    @State private var isShownHome: Bool = false
    @State private var phoneNumber: String = ""
    
    private var isValidPhoneNumber: Bool {
        !phoneNumber.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if isShownHome {
                    HomeScreen()
                } else {
                    ZStack {
                        Color.primarySystem.ignoresSafeArea()
                        
                        VStack(alignment: .leading, spacing: 30) {
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
                                
                                Button {
                                    withAnimation(.spring) { isShownHome = true }
                                } label: {
                                    BorderedLabel(
                                        title: "Next",
                                        imageName: "arrow.right")
                                }
//                                .opacity(isValidPhoneNumber ? 1.0 : 0.5)
                            }
                            HStack(spacing: 5) {
                                Text("New member?")
                                    .font(.poppins(.regular, size: 14))
                                    .foregroundStyle(.primaryReversed)
                                    .opacity(0.6)
                                
                                NavigationLink {
                                    SignUpScreen()
                                } label: {
                                    Text("Sign Up")
                                        .font(.poppins(.medium, size: 14))
                                        .foregroundStyle(.primaryReversed)
                                }
                            }
                        }
                        .padding(.horizontal, 30)
                    }
                }
            }
        }
    }
}

#Preview {
    SignInScreen()
}
