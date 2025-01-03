//
//  OrderPaymentScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentScreen: View {
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 50) {
        PaymentScreenHeader()
        PaymentMethodsContainer()
          .shadow(radius: 5)
          .padding(.top, 50)
          .padding()
      }
    }
    .navigationTitle("My order")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ArrowBackBtn()
      }
    }
  }
}

#Preview {
  PaymentScreen()
}

struct PaymentScreenHeader: View {
  var body: some View {
    Text("")
  }
}
