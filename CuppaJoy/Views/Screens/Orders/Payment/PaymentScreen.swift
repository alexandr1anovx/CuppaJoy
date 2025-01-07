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
          .padding()
      }
    }
  }
}

#Preview {
  PaymentScreen()
}

struct PaymentScreenHeader: View {
  @Environment(\.dismiss) var dismiss
  var body: some View {
    HStack {
      Spacer()
      Image(systemName: "xmark.circle.fill")
        .font(.title)
        .foregroundStyle(.cstGray)
        .onTapGesture {
          dismiss()
        }
    }.padding(.horizontal)
  }
}
