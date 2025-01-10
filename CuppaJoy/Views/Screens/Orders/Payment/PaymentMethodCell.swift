//
//  PaymentMethodCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentMethodCell: View {
  @State private var isShownApplePay: Bool = false
  
  var body: some View {
    List {
      ApplePaymentCell(isShownApplePay: $isShownApplePay)
    }
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .sheet(isPresented: $isShownApplePay) {
      ApplePayView()
        .presentationDetents([.medium])
        .presentationDragIndicator(.visible)
        .presentationBackgroundInteraction(.disabled)
    }
  }
}

#Preview {
  PaymentMethodCell()
}

struct ApplePaymentCell: View {
  @Binding var isShownApplePay: Bool
  
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
    .onTapGesture { isShownApplePay.toggle() }
    .listRowBackground(Color.cstBlack)
  }
}

/*
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
*/
