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
      
      LinearGradient(
        colors: [.cstDarkBrown, .cstBlue],
        startPoint: .top,
        endPoint: .bottom).ignoresSafeArea()
      
      VStack(spacing: 15) {
        Image("takeaway")
          .resizable()
          .frame(width: 140, height: 140)
          .foregroundStyle(.cstCream)
        Text("Order accepted!")
          .font(.poppins(.bold, size: 20))
          .foregroundStyle(.cstCream)
        
        VStack(alignment: .center, spacing: 20) {
          Text("The order will be ready today to 18:10 at the address Bradford BD1 1PR.")
            .foregroundStyle(.cstCream)
          
          Text("Submit your personal QR code at the coffee shop to receive an order.")
            .foregroundStyle(.cstGray)
        }
        .padding(.top, 20)
        .font(.poppins(.regular, size: 14))
        .padding(.horizontal, 30)
        .multilineTextAlignment(.center)
      }
    }
  }
}

#Preview {
  CompletedOrderScreen()
}
