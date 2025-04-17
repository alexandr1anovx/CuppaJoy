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
  @State private var isShownDismissAlert = false
  
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
        Button("Dismiss") {
          isShownDismissAlert.toggle()
        }.foregroundStyle(.red)
      }
    }
    .alert(isPresented: $isShownDismissAlert) {
      Alert(
        title: Text("You changed your mind?"),
        message: Text("You can return to the main screen to cancel the current order."),
        primaryButton: .cancel(),
        secondaryButton: .default(Text("Home")) {
          path.removeLast(path.count)
          isTabBarVisible = true
        }
      )
    }
  }
}
