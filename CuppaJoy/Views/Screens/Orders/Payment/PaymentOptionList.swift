//
//  PaymentOptionView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.01.2025.
//

import SwiftUI

private enum PaymentOption {
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
  @State private var selectedOption = PaymentOption.applePay
  
  var body: some View {
    List {
      paymentCell(option: .applePay, isDisabled: false)
      paymentCell(option: .creditCard, isDisabled: true)
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
  }
  
  // MARK: Payment Cell
  private func paymentCell(option: PaymentOption, isDisabled: Bool) -> some View {
    HStack {
      Image(systemName: option.iconName)
        .imageScale(.large)
        .foregroundColor(.white)
        .padding(.trailing, 8)
      Text(option.title)
        .font(.subheadline)
        .fontDesign(.monospaced)
      Spacer()
      
      if isDisabled {
        Text("unavailable now")
          .foregroundStyle(.red)
      } else {
        Image(systemName: "checkmark")
          .bold()
          .foregroundStyle(
            selectedOption == option ? .accent : .clear
          )
      }
    }
    .opacity(isDisabled ? 0.3 : 1)
    .padding(.vertical, 10)
    .onTapGesture {
      if !isDisabled {
        selectedOption = option
      }
    }
  }
}
#Preview {
    PaymentOptionList()
}
