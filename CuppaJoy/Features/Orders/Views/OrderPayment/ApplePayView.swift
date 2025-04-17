//
//  ApplePayView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.01.2025.
//

import SwiftUI

struct ApplePayView: View {
  
  // MARK: Properties
  let order: Order
  let feedbackGenerator = UINotificationFeedbackGenerator() // haptic feedback.
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  @State private var isShownAlert = false
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var orderViewModel: OrderViewModel
  @EnvironmentObject var authViewModel: AuthViewModel
  
  // MARK: Body
  var body: some View {
    VStack {
      // Header
      HStack {
        Label("Pay", systemImage: "apple.logo").font(.title2)
        Spacer()
        DismissButton()
      }
      .padding(.top)
      .padding(.horizontal)
      
      List {
        firstSectionView
        secondSectionView
        thirdSectionView
      }
      .customListStyle()
      .shadow(radius: 1)
      
      paymentButton
    }
    .alert(isPresented: $isShownAlert) { // Alert for successful payment.
      Alert(
        title: Text("Success!"),
        message: Text("The order has been placed in the queue. You can cancel it on the order screen."),
        dismissButton: .default(Text("Got it!")) {
          dismiss()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            path.removeLast(path.count)
            isTabBarVisible = true
          }
        }
      )
    }
  }
  
  private var firstSectionView: some View {
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
  
  private var secondSectionView: some View {
    VStack(alignment: .leading, spacing: 5) {
      Text(order.stringPrice)
        .font(.headline)
        .fontWeight(.semibold)
      Text("One-time purchase")
        .font(.footnote)
        .foregroundStyle(.gray)
    }
  }
  
  private var thirdSectionView: some View {
    HStack {
      Text("Account:")
      Text("icloudname@icloud.com").tint(.gray)
    }
    .font(.subheadline)
    .fontWeight(.medium)
  }
  
  private var paymentButton: some View {
    Button {
      Task {
        await authViewModel.addCoinsToUser(order.points)
        orderViewModel.setOngoingOrders(order)
        isShownAlert.toggle()
        orderViewModel.setOngoingOrders(order)
        feedbackGenerator.notificationOccurred(.success)
      }
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
