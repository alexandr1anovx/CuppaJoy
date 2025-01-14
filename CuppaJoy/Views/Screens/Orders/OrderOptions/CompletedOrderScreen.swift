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
      
      VStack(spacing: 25) {
        Image("takeaway")
          .resizable()
          .frame(width: 130, height: 130)
          .foregroundStyle(.accent)
        Text("Order received!")
          .font(.poppins(.medium, size: 17))
          .foregroundStyle(.accent)
        
        Text("The order will be ready today to 18:10 at the address Bradford BD1 1PR.")
          .foregroundStyle(.cstGray)
        .font(.poppins(.regular, size: 13))
        .padding(.horizontal, 30)
        .multilineTextAlignment(.center)
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
