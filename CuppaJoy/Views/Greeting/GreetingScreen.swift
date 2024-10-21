//
//  GreetingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct GreetingScreen: View {
    
    @State private var isShownSignIn: Bool = false
    
    var body: some View {
        Group {
            if isShownSignIn {
                SignInScreen()
            } else {
                ZStack {
                    Color.primarySystem.ignoresSafeArea()
                    
                    VStack {
                        Image(.header)
                            .shadow(color: .primaryMint, radius: 5)
                        VStack(spacing: 8) {
                            Text("Feel yourself like a barista!")
                                .font(.poppins(.regular, size: 25))
                                .foregroundStyle(.primaryReversed)
                                .multilineTextAlignment(.center)
                            
                            Text("Magic coffee on order.")
                                .font(.poppins(.regular, size: 15))
                                .foregroundStyle(.primaryGray)
                        }
                        .padding(.vertical, 60)
                        
                        Button {
                            withAnimation(.smooth) { isShownSignIn = true }
                        } label: {
                            BorderedLabel(
                                title: "Get Started",
                                imageName: "checkmark"
                            )
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    GreetingScreen()
}
