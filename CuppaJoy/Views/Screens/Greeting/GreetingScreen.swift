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
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(spacing: 50) {
        
        VStack(spacing: 10) {
          Text("Feel yourself like a barista 😊")
            .font(.poppins(.medium, size: 20))
            .foregroundStyle(.cstCream)
            .multilineTextAlignment(.center)
          
          Text("Magic coffee on order.")
            .font(.poppins(.medium, size: 14))
            .foregroundStyle(.cstGray)
        }
        .foregroundStyle(.cstMint)
        
        Button {
          withAnimation(.smooth) {
            // show screen action
          }
        } label: {
          Text("Get Started")
            .font(.poppins(.bold, size: 16))
            .foregroundStyle(.cstCream)
            .padding(5)
        }
        .buttonStyle(.bordered)
        .tint(.cstCream)
      }
    }
  }
}

#Preview {
  GreetingScreen()
}
