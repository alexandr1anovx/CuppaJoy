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
      Color.cstDarkBrown.ignoresSafeArea()
      
      VStack(spacing: 60) {
        Image("header")
        VStack(spacing: 10) {
          Text("Feel yourself like a barista 😊")
            .font(.poppins(.medium, size: 22))
            .foregroundStyle(.cstCream)
            .multilineTextAlignment(.center)
          
          Text("Magic coffee on order.")
            .font(.poppins(.medium, size: 14))
            .foregroundStyle(.cstGray)
        }
        .foregroundStyle(.cstMint)
        
        CustomBtn("Get Started") {
          withAnimation(.smooth) {
            // show screen action
          }
        }
      }
    }
  }
}

#Preview {
  GreetingScreen()
}
