//
//  OrderPaymentScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentScreen: View {
  
  let order: Order
  
  var body: some View {
    NavigationStack {
      ZStack {
        Color.csBlack.ignoresSafeArea(.all)
        PaymentOptionContainer(order: order)
      }
      .navigationTitle("Payment")
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
  PaymentScreen(order: MockData.order)
}
