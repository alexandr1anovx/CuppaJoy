//
//  GreetingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 04.10.2024.
//

import SwiftUI

struct GreetingScreen: View {
    
    var body: some View {
        ZStack {
            Color.primaryBrown.ignoresSafeArea()
            
            VStack(spacing: 50) {
                Image("header")
                    .shadow(color: .primaryDarkBrown, radius: 5)
                VStack(spacing: 10) {
                    Text("Feel yourself like a barista.")
                        .font(.poppins(.regular, size: 25))
                        .multilineTextAlignment(.center)
                    
                    Text("Magic coffee on order.")
                        .font(.poppins(.regular, size: 15))
                        .foregroundStyle(.primaryWhite)
                }
                .foregroundStyle(.primaryMint)
                
                MainButton("Get Started") {
                    withAnimation(.smooth) {
                        // show Sign In screen
                    }
                }
            }
            .padding(50)
        }
    }
}

#if DEBUG
#Preview {
    GreetingScreen()
}
#endif
