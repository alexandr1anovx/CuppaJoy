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
  @State private var showDismissAlert = false
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea()
      OrderPaymentOptionView(
        order: order,
        path: $path,
        isTabBarVisible: $isTabBarVisible
      )
    }
    .navigationTitle("Complete Your Order")
    .navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarTrailing) {
        Button {
          showDismissAlert.toggle()
        } label: {
          Image(systemName: "xmark.circle.fill")
            .font(.title3)
            .foregroundStyle(.red)
            .symbolRenderingMode(.hierarchical)
        }
      }
    }
    .alert(isPresented: $showDismissAlert) {
      Alert(
        title: Text("Cancel Payment?"),
        message: Text("Are you sure you want to cancel this payment? Your order details will be lost."),
        primaryButton: .destructive(Text("Cancel")),
        secondaryButton: .default(Text("Go Home")) {
          path.removeLast(path.count)
          isTabBarVisible = true
        }
      )
    }
  }
  
}

#Preview {
  OrderPaymentScreen(
    order: MockData.order,
    isTabBarVisible: .constant(false),
    path: .constant(NavigationPath())
  )
  
}
