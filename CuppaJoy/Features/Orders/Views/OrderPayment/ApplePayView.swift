//
//  ApplePayView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 08.01.2025.
//

import SwiftUI

enum PaymentMethod {
  case applePay
  case creditCard
  
  var title: String {
    switch self {
    case .applePay: "Apple Pay"
    case .creditCard: "Credit Card"
    }
  }
  var iconName: String {
    switch self {
    case .applePay: "apple.logo"
    case .creditCard: "creditcard.fill"
    }
  }
}

struct ApplePayView: View {
  @Environment(\.dismiss) var dismiss
  @Environment(OrderViewModel.self) var orderViewModel
  
  let order: Order
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  @State private var showAlert = false
  
  private let feedbackGenerator = UINotificationFeedbackGenerator()
  
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
      
      Form {
        firstSectionView
        secondSectionView
        thirdSectionView
      }.shadow(radius: 1)
      
      paymentButton
    }
    .alert(isPresented: $showAlert) {
      Alert(
        title: Text("Success!"),
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
  
  // MARK: - Subviews
  
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
        Text("your.email@example.com").tint(.gray)
    }
    .font(.subheadline)
    .fontWeight(.medium)
  }
  
  private var paymentButton: some View {
    Button {
      Task {
        await orderViewModel.makeOrder(order)
        showAlert.toggle()
        feedbackGenerator.notificationOccurred(.success)
      }
    } label: {
      CapsuleLabelWithIcon(
        "Confirm Payment",
        icon: "checkmark.circle.fill",
        textColor: .white,
        bgColor: .blue
      )
    }
  }
}
