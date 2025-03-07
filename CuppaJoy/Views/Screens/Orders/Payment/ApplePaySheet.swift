//
//  ApplePayView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.01.2025.
//

import SwiftUI

struct ApplePaySheet: View {
  
  let order: Order
  @State private var isShownAlert = false
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var orderViewModel: OrderViewModel
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        applePayLabel
        Spacer()
        DismissButton()
      }
      .padding(.top)
      .padding(.horizontal)
      orderList
      confirmPaymentButton
    }
    .alert(isPresented: $isShownAlert) {
      Alert(
        title: Text("Congratulations!🔥"),
        message: Text("Payment has been successfully processed."),
        dismissButton: .default(Text("Done")) {
          dismiss()
        }
      )
    }
  }
  
  private var orderList: some View {
    List {
      productDataLabel
      productPriceLabel
      accountLabel
    }
    .listStyle(.insetGrouped)
    .scrollContentBackground(.hidden)
    .shadow(radius: 1)
  }
  
  private var applePayLabel: some View {
    Label("Pay", systemImage: "apple.logo")
      .font(.title2)
  }
  
  private var productDataLabel: some View {
    HStack(spacing: 20) {
      Image(.marker)
        .foregroundStyle(.accent)
      VStack(alignment: .leading, spacing: 5) {
        Text("\(order.cupSize) Cup")
          .font(.callout)
          .fontWeight(.semibold)
        Text("Cuppa Joy")
          .font(.footnote)
          .foregroundStyle(.gray)
        Text("In-App Purchase")
          .font(.footnote)
          .foregroundStyle(.gray)
      }
    }
  }
  
  private var productPriceLabel: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(order.stringPrice)
        .font(.headline)
        .fontWeight(.semibold)
      Text("One-time purchase")
        .font(.footnote)
        .foregroundStyle(.gray)
    }
  }
  
  private var accountLabel: some View {
    HStack {
      Text("Account:")
      Text("icloudname@icloud.com")
        .tint(.gray)
    }
    .font(.subheadline)
    .fontWeight(.medium)
  }
  
  private var confirmPaymentButton: some View {
    Button {
      Task {
        await authViewModel.addCoinsToUser(order.points)
      }
      orderViewModel.setOngoingOrders(order)
      isShownAlert.toggle()
    } label: {
      ButtonLabelWithIcon(
        "Confirm Payment",
        icon: "checkmark.circle.fill",
        textColor: .white,
        pouring: .blue
      )
    }
  }
}

#Preview {
  ApplePaySheet(order: MockData.order)
}
