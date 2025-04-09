//
//  OrderPaymentScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct OrderPaymentScreen: View {
  
  let order: Order
  @Binding var isTabBarVisible: Bool
  @Binding var path: NavigationPath
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      OrderPaymentOptionView(
        order: order,
        path: $path,
        isTabBarVisible: $isTabBarVisible
      )
    }
    .navigationTitle("Payment")
    .navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        DismissButton()
      }
    }
  }
}
