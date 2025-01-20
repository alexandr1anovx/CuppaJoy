//
//  CompletedOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 27.10.2024.
//

import SwiftUI

struct CompletedOrderScreen: View {
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack(spacing: 20) {
        Image(.takeaway)
          .resizable()
          .frame(width: 100, height: 100)
        
        Text("Order received.")
          .font(.poppins(.bold, size: 16))
          .foregroundStyle(.csYellow)
        
        VStack(spacing: 10) {
          
          HStack(spacing: 5) {
            Text("Address:")
              .font(.poppins(.medium, size: 13))
              .foregroundStyle(.gray)
            Text("Bradford BD1 1PR.")
              .font(.poppins(.bold, size: 13))
              .foregroundStyle(.accent)
          }
          
          Text("We will call you as soon as the courier arrives at the specified location.")
            .font(.poppins(.medium, size: 12))
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 30)
        }
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ReturnButton()
      }
    }
  }
}

#Preview {
  CompletedOrderScreen()
}
