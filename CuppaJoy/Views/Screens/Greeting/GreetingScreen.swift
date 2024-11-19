//
//  GreetingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct GreetingScreen: View {
    @State private var isShownSignIn = false
    
    var body: some View {
        Group {
            if isShownSignIn {
                SignInScreen()
            } else {
                ZStack {
                    Color.primarySystem.ignoresSafeArea()
                    
                    VStack {
                        Image("header")
                            .shadow(color: .primaryMint, radius: 5)
                        VStack(spacing: 10) {
                            Text("Feel yourself like a barista!")
                                .font(.poppins(.regular, size: 23))
                                .multilineTextAlignment(.center)
                            
                            Text("Magic coffee on order.")
                                .font(.poppins(.regular, size: 15))
                                .foregroundStyle(.primaryWhite)
                        }
                        .foregroundStyle(.primaryMint)
                        .padding(.vertical, 60)
                         
                        MainButton("Get Started") {
                            withAnimation(.smooth) {
                                isShownSignIn = true
                            }
                        }
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview { GreetingScreen() }
#endif
