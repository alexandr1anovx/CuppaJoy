//
//  OrderPaymentScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentOptionScreen: View {
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.csBlack.ignoresSafeArea(.all)
        PaymentOptionContainer()
      }
      .navigationTitle("Payment Options")
      .navigationBarTitleDisplayMode(.inline)
      .navigationBarBackButtonHidden(true)
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          DismissButton()
        }
      }
    }
  }
}

#Preview {
  PaymentOptionScreen()
}
