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
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(spacing: 20) {
        Image(.coffee2)
          .resizable()
          .frame(width: 100, height: 100)
        
        Text("Order received!")
          .font(.poppins(.bold, size: 16))
          .foregroundStyle(.white)
        
        VStack(spacing: 10) {
            
          HStack(spacing: 5) {
            Text("Address:")
              .font(.poppins(.medium, size: 13))
              .foregroundStyle(.gray)
              .fontWeight(.medium)
            Text("Bradford BD1 1PR.")
              .font(.poppins(.medium, size: 13))
              .foregroundStyle(.accent)
              .fontWeight(.bold)
          }
          
          Text("We will call you as soon as the courier arrives at the specified location.")
            .font(.poppins(.medium, size: 12))
            .foregroundStyle(.gray)
          
            .foregroundStyle(.gray)
          .font(.poppins(.regular, size: 12))
          .padding(.horizontal, 30)
          .multilineTextAlignment(.center)
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
