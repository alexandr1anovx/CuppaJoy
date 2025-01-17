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
    HStack(alignment: .bottom) {
      
      Image(systemName: "apple.logo")
        .font(.title2)
      Text("Pay")
        .font(.title3)
        .fontWeight(.medium)
      
    }
    .foregroundStyle(.white)
    .padding(10)
    .listRowBackground(Color.black)
    .onTapGesture { isShownApplePay = true }
  }
}
