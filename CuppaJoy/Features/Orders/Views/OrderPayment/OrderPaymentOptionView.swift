//
//  OrderPaymentView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct OrderPaymentOptionView: View {
  
  let order: Order
  @Binding var path: NavigationPath
  @Binding var isTabBarVisible: Bool
  @State private var isShownPaymentView = false
  
  var body: some View {
    VStack(spacing: 20) {
      orderConfigurationsButton
      OrderPaymentOptionsList()
      Spacer()
      paymentStack
    }
    .padding(.top)
    .sheet(isPresented: $isShownPaymentView) {
      ApplePayView(
        order: order,
        path: $path,
        isTabBarVisible: $isTabBarVisible
      )
      .presentationDetents([.height(340)])
      .presentationBackgroundInteraction(.disabled)
      .presentationCornerRadius(30)
    }
  }
  
  private var orderConfigurationsButton: some View {
    Button {
      print("Showed order configurations")
    } label: {
      ButtonLabelWithIcon(
        "Order Configurations",
        icon: "text.badge.checkmark",
        textColor: .csCream,
        bgColor: .csDarkGrey
      )
    }
  }
  
  private var paymentStack: some View {
    VStack(spacing: 25) {
      
      HStack(spacing: 5) {
        Text("Total Amount:")
          .font(.callout)
          .fontWeight(.medium)
          .foregroundStyle(.gray)
        Text(order.formattedPrice)
          .font(.headline)
          .fontWeight(.bold)
          .foregroundStyle(.white)
      }
      
      Button {
        isShownPaymentView.toggle()
      } label: {
        ButtonLabelWithIcon(
          "Pay",
          icon: "apple.logo",
          textColor: .white,
          bgColor: .blue
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 30)
        .fill(Color.black)
        .ignoresSafeArea(.all)
        .frame(height: 150)
    )
  }
}

#Preview {
  OrderPaymentOptionView(
    order: MockData.order,
    path: .constant(NavigationPath()),
    isTabBarVisible: .constant(false)
  )
}
