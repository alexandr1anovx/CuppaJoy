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
      
      VStack(spacing: 15) {
        Image("takeaway")
          .resizable()
          .frame(width: 140, height: 140)
          .foregroundStyle(.cstCream)
        Text("Order received!")
          .font(.poppins(.medium, size: 18))
          .foregroundStyle(.cstCream)
        
        VStack(alignment: .center, spacing: 20) {
          Text("The order will be ready today to 18:10 at the address Bradford BD1 1PR.")
            .foregroundStyle(.cstCream)
          
          Text("* submit your personal QR code at the coffee shop to receive an order.")
            .foregroundStyle(.cstGray)
        }
        .padding(.top, 30)
        .font(.poppins(.regular, size: 14))
        .padding(.horizontal, 30)
        .multilineTextAlignment(.center)
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ArrowBackBtn()
      }
    }
  }
}

#Preview {
  CompletedOrderScreen()
}
