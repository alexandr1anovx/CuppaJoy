//
//  SignInScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct SignInScreen: View {
    @State private var isShownHome = false
    @State private var phoneNumber = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if isShownHome {
                    CustomTabBar()
                } else {
                    ZStack {
                        Color.primarySystem.ignoresSafeArea()
                        
                        VStack(alignment: .leading, spacing: 30) {
                            HeaderLabel(
                                title: "Sign In",
                                subtitle: "Welcome back!"
                            )
                            CustomTextField(
                                imageName: "phone",
                                placeholder: "Phone Number",
                                inputData: $phoneNumber
                            )
                            
                            HStack {
                                Spacer()
                                RoundedButton("Next", image: "arrow.right") {
                                    withAnimation(.spring) {
                                        isShownHome = true
                                    }
                                }
                            }
                            HStack(spacing: 5) {
                                Text("New member?")
                                    .font(.poppins(.regular, size: 14))
                                    .foregroundStyle(.primaryMint)
                                    .opacity(0.6)
                                
                                NavigationLink {
                                    SignUpScreen()
                                } label: {
                                    Text("Sign Up")
                                        .font(.poppins(.medium, size: 14))
                                        .foregroundStyle(.primaryMint)
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

#if DEBUG
#Preview {
    SignInScreen()
}
#endif
