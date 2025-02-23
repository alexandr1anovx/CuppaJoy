//
//  OrderPaymentView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentOptionContainer: View {
  
  let order: Order
  @State private var isShownApplePay = false
  
  var body: some View {
    VStack {
      userDataView
      PaymentOptionList()
        .shadow(radius: 2)
      Spacer()
      footerView
    }
    .padding(.vertical, 25)
    .sheet(isPresented: $isShownApplePay) {
      ApplePaySheet(order: order)
        .presentationDetents([.height(380)])
        .presentationBackgroundInteraction(.disabled)
    }
  }
  
  // MARK: - User Data
  private var userDataView: some View {
    HStack {
      Image(.man)
        .foregroundStyle(.accent)
        .padding(12)
        .background(.black)
        .clipShape(.capsule)
      VStack(alignment: .leading, spacing: 8) {
        Text("Username")
          .font(.headline)
        Text("Coffee Store Address")
          .font(.footnote)
          .foregroundStyle(.gray)
          .lineLimit(2)
          .multilineTextAlignment(.leading)
      }
      Spacer()
    }
    .padding(.top, 10)
    .padding(.leading, 20)
  }
  
  // MARK: - Footer
  private var footerView: some View {
    HStack {
      VStack(spacing: 10) {
        Text("Total Amount:")
          .font(.callout).bold()
          .foregroundStyle(.gray)
        Text("$\(order.totalPrice, specifier: "%.2f")")
          .font(.title2).bold()
      }
      Spacer()
      Button {
        isShownApplePay.toggle()
      } label: {
        Text("Confirm")
          .font(.callout).bold()
          .foregroundStyle(.accent)
          .padding(10)
      }
      .buttonStyle(.borderedProminent)
      .tint(.black)
    }
    .padding(.horizontal, 20)
  }
}

#Preview {
  PaymentOptionContainer(order: MockData.order)
}
