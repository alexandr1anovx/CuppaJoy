//
//  PaymentOptionView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.01.2025.
//

import SwiftUI

struct OrderPaymentOptionsList: View {
  @State private var selectedMethod: PaymentMethod = .applePay
  
  var body: some View {
    List {
      Section("Select a convenient payment method") {
        cell(for: .applePay, isAvailable: true)
        cell(for: .creditCard, isAvailable: false)
      }
    }
    .listStyle(.insetGrouped)
    .environment(\.defaultMinListRowHeight, 55)
    .listRowSpacing(15)
    .scrollContentBackground(.hidden)
  }
  
  @ViewBuilder
  private func cell(for method: PaymentMethod, isAvailable: Bool) -> some View {
    HStack(spacing: 13) {
      Image(systemName: method.iconName)
        .imageScale(.large)
        .foregroundColor(.white)
      Text(method.title)
        .font(.subheadline)
        .fontWeight(.semibold)
      Spacer()
      if isAvailable {
        Image(systemName: "checkmark")
          .imageScale(.medium)
          .fontWeight(.medium)
          .foregroundStyle(
            selectedMethod == method ? .csCream : .clear
          )
      } else {
        Text("unavailable now").foregroundStyle(.red)
      }
    }
    .opacity(isAvailable ? 1 : 0.5)
    .padding(.vertical, 8)
    .onTapGesture {
      if isAvailable {
        selectedMethod = method
      }
    }
  }
}
#Preview {
  OrderPaymentOptionsList()
}
