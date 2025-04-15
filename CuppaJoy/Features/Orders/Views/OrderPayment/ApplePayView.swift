//
//  ApplePayView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.01.2025.
//

import SwiftUI

struct ApplePayView: View {
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var orderViewModel: OrderViewModel
  @EnvironmentObject var authViewModel: AuthViewModel
  let generator = UINotificationFeedbackGenerator()
  
  let order: Order
  @State private var isShownAlert = false
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  
  var body: some View {
    VStack{
      HStack{
        applePayLabel
        Spacer()
        DismissButton()
      }
      .padding(.top)
      .padding(.horizontal)
      orderItemsList
      confirmPaymentButton
    }
    .alert(isPresented: $isShownAlert) {
      Alert(
        title: Text("Congratulations 🔥"),
        message: Text("Payment has been successfully processed."),
        dismissButton: .default(Text("Back to Home")) {
          dismiss()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            path.removeLast(path.count)
            isTabBarVisible = true
          }
        }
      )
    }
  }
  
  private var orderItemsList: some View {
    List {
      coffeeDataLabel
      coffeePriceLabel
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
  
  private var coffeeDataLabel: some View {
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
  
  private var coffeePriceLabel: some View {
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
      Text("icloudname@icloud.com").tint(.gray)
    }
    .font(.subheadline)
    .fontWeight(.medium)
  }
  
  private var confirmPaymentButton: some View {
    Button {
      Task {
        await authViewModel.addCoinsToUser(order.points)
        orderViewModel.setOngoingOrders(order)
        isShownAlert.toggle()
      }
      orderViewModel.setOngoingOrders(order)
      isShownAlert.toggle()
      generator.notificationOccurred(.success)
    } label: {
      ButtonLabelWithIcon(
        "Confirm Payment",
        icon: "checkmark.circle.fill",
        textColor: .white,
        bgColor: .blue
      )
    }
  }
}

#Preview {
  ApplePayView(
    order: MockData.order,
    path: .constant(NavigationPath()),
    isTabBarVisible: .constant(false)
  )
}
