//
//  PaymentMethodCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentMethodCell: View {
  var body: some View {
    List {
      CreditCardPaymentCell()
      ApplePaymentCell()
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  PaymentMethodCell()
}

struct CreditCardPaymentCell: View {
  var body: some View {
    HStack(spacing: 20) {
      VStack(alignment: .leading, spacing: 10) {
        Text("Credit Card")
          .font(.poppins(.medium, size: 16))
          .foregroundStyle(.cstWhite)
        Text("2540 xxxx xxxx 2648")
          .font(.poppins(.medium, size: 14))
          .foregroundStyle(.cstGray)
      }
      Spacer()
      Image("visa")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
    }
    .listRowBackground(Color.cstBlack)
  }
}

struct ApplePaymentCell: View {
  var body: some View {
    HStack(spacing: 20) {
      Text("Apple Pay")
        .font(.poppins(.medium, size: 16))
        .foregroundStyle(.cstWhite)
      Spacer()
      Image("applePay")
        .resizable()
        .scaledToFit()
        .frame(width: 40, height: 40)
    }
    .listRowBackground(Color.cstBlack)
  }
}
