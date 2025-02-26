//
//  PaymentOptionView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.01.2025.
//

import SwiftUI

private enum PaymentMethod {
  case applePay, creditCard
  
  var iconName: String {
    switch self {
    case .applePay: "apple.logo"
    case .creditCard: "creditcard.fill"
    }
  }
  
  var title: String {
    switch self {
    case .applePay: "Apple Pay"
    case .creditCard: "Credit Card"
    }
  }
}

struct PaymentOptionList: View {
  @State private var selectedMethod: PaymentMethod = .applePay
  
  var body: some View {
    List {
      cell(for: .applePay, isAvailable: true)
      cell(for: .creditCard, isAvailable: false)
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
  }
  
  // MARK: Payment Cell
  private func cell(for method: PaymentMethod, isAvailable: Bool) -> some View {
    HStack(spacing: 12) {
      
      Image(systemName: method.iconName)
        .imageScale(.large)
        .foregroundColor(.white)
      Text(method.title)
        .font(.subheadline)
        .fontWeight(.bold)
      
      Spacer()
      
      if isAvailable {
        Image(systemName: "checkmark.circle.fill")
          .imageScale(.large)
          .symbolRenderingMode(.hierarchical)
          .foregroundStyle(
            selectedMethod == method ? .csCream : .clear
          )
      } else {
        Text("Unavailable now")
          .foregroundStyle(.red)
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
    PaymentOptionList()
}
