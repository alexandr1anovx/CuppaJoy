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
//  @StateObject private var orderViewModel = OrderViewModel()
  @EnvironmentObject var orderViewModel: OrderViewModel
  
  var body: some View {
    NavigationStack {
      List {
        orderTitleSection
        orderPriceSection
        accountNameSection
      }
      .listStyle(.insetGrouped)
      .scrollContentBackground(.hidden)
      .shadow(radius: 1)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          applePayImage
        }
        ToolbarItem(placement: .topBarTrailing) {
          DismissButton()
        }
        ToolbarItem(placement: .bottomBar) {
          footer
        }
      }
      .alert(isPresented: $isShownAlert) {
        Alert(
          title: Text("Success 😎"),
          message: Text("Payment has been successfully processed."),
          dismissButton: .default(Text("Got it")) {
            dismiss()
          }
        )
      }
    }
  }
  
  // MARK: Apple Pay Image
  private var applePayImage: some View {
    HStack {
      Image(systemName: "apple.logo")
      Text("Pay").font(.title2)
    }
  }
  
  // MARK: Order Title
  private var orderTitleSection: some View {
    HStack(spacing: 20) {
      Image(.coffee)
        .foregroundStyle(.accent)
      VStack(alignment: .leading, spacing: 5) {
        Text("Medium Cup")
          .font(.callout)
          .fontWeight(.medium)
        Text("Cuppa Joy")
          .font(.footnote)
          .foregroundStyle(.gray)
        Text("In-App Purchase")
          .font(.footnote)
          .foregroundStyle(.gray)
      }
    }
  }
  
  // MARK: Order Price
  private var orderPriceSection: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text("$\(order.totalPrice, specifier: "%.2f")")
        .font(.title3).bold()
      Text("One-time charge")
        .font(.footnote)
        .foregroundStyle(.gray)
    }
  }
  
  // MARK: Account Name
  private var accountNameSection: some View {
    Text("Account: sashaandrianov@icloud.com")
      .font(.callout)
      .tint(.gray)
  }
  
  // MARK: Footer (confirmation action)
  private var footer: some View {
    Button {
      isShownAlert.toggle()
      orderViewModel.addOrder(order)
    } label: {
      Text("Confirm Payment")
        .bold()
        .foregroundStyle(.white)
        .padding(8)
    }
    .tint(.blue)
    .buttonStyle(.borderedProminent)
  }
}

#Preview {
  ApplePaySheet(order: MockData.order)
}
