//
//  GreetingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct GreetingScreen: View {
    
    @State private var isPresentedSignInScreen = false
    
    var body: some View {
        Group {
            if isPresentedSignInScreen {
                SignInScreen()
            } else {
                ZStack {
                    Color.customSystem.ignoresSafeArea()
                    
                    VStack {
                        Image(.header)
                            .shadow(color: .customMintGreen, radius: 5)
                        
                        VStack(spacing: 8) {
                            Text("Feel yourself like a barista!")
                                .font(.poppins(.regular, size: 25))
                                .foregroundStyle(.customReversed)
                                .multilineTextAlignment(.center)
                            
                            Text("Magic coffee on order.")
                                .font(.poppins(.regular, size: 15))
                                .foregroundStyle(.customReversed)
                                .opacity(0.6)
                        }
                        .padding(.vertical, 60)
                        
                        Button {
                            withAnimation(.smooth(duration: 0.7)) {
                                isPresentedSignInScreen.toggle()
                            }
                        } label: {
                            Label("Get Started", systemImage: "arrow.up")
                                .font(.poppins(.medium, size: 15))
                                .foregroundStyle(.customSystem)
                                .padding(13)
                                .background(.customReversed)
                                .clipShape(.buttonBorder)
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
