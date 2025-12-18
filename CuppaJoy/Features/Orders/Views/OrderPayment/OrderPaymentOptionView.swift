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
  @State private var showPaymentView = false
  
  var body: some View {
    VStack(spacing: 20) {
      OrderPaymentOptionsList()
      Spacer()
      paymentStack
    }
    .padding(.top)
    .sheet(isPresented: $showPaymentView) {
      ApplePayView(
        order: order,
        path: $path,
        isTabBarVisible: $isTabBarVisible
      )
      .presentationDetents([.height(350)])
      .presentationBackgroundInteraction(.disabled)
      .presentationCornerRadius(30)
    }
  }
  
  private var paymentStack: some View {
    VStack(spacing: 25) {
      Button {
        // ...
      } label: {
        Text("Check my order details.")
          .font(.callout)
          .foregroundStyle(.orange)
          .underline()
      }
      
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
        showPaymentView.toggle()
      } label: {
        ButtonLabelWithIcon(
          "Pay",
          icon: "apple.logo",
          textColor: .white,
          bgColor: .black
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 30)
        .fill(Color.csBlack)
        .shadow(color: .white, radius: 1)
        .ignoresSafeArea(.all)
        .frame(height: 200)
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
