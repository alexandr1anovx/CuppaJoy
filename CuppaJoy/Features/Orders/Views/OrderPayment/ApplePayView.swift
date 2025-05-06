//
//  ApplePayView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.01.2025.
//

import SwiftUI

struct ApplePayView: View {
  
  private let feedbackGenerator = UINotificationFeedbackGenerator()
  
  let order: Order
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  
  @State private var isShownAlert = false
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var orderViewModel: OrderViewModel
  
  var body: some View {
    VStack(spacing: 5) {
      HStack {
        Label("Pay", systemImage: "apple.logo")
          .font(.title2)
        Spacer()
        DismissButton(color: .red)
      }
      .padding(.top, 20)
      .padding(.horizontal, 20)
      
      List {
        firstSectionView
        secondSectionView
        thirdSectionView
      }
      .customListStyle(shadowRadius: 1)
      
      paymentButton
    }
    .alert(isPresented: $isShownAlert) {
      Alert(
        title: Text("✅ Success!"),
        message: Text("The order has been placed in the queue."),
        dismissButton: .default(Text("OK")) {
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
      Text(order.formattedPrice)
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
        orderViewModel.setOngoingOrder(order)
        isShownAlert.toggle()
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
