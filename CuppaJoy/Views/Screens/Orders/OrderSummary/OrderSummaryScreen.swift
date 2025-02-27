//
//  OrderSummaryScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import SwiftUI

struct OrderSummaryScreen: View {
  
  let order: Order
  @State private var isShownPaymentScreen = false
  @Environment(\.dismiss) var dismiss
  
  var body: some View {
    ZStack {
      Color.csBlack.ignoresSafeArea(.all)
      VStack {
        List {
          orderItemRow("Coffee:", data: order.coffee)
          orderItemRow("Size:", data: order.cupSize)
          orderItemRow("Count:", data: "\(order.cupCount)")
          
          // Only selected additives are shown
          
          if order.sugarSticks > 0 {
            orderItemRow("Sugar sticks:", data: "\(order.sugarSticks)")
          }
          if order.iceCubes > 0 {
            orderItemRow("Ice cubes:", data: "\(order.iceCubes)")
          }
          
          orderItemRow("Variety:", data: order.variety)
          
          if order.milk != "" {
            orderItemRow("Milk:", data: order.milk)
          }
          if order.flavor != "" {
            orderItemRow("Flavor:", data: order.flavor)
          }
          orderItemRow("Total:", data: String(format: "$%.2f", order.totalPrice))
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(10)
        .scrollContentBackground(.hidden)
        
        confirmationFooterView
      }
    }
    .navigationTitle("Order Summary")
    .fullScreenCover(isPresented: $isShownPaymentScreen) {
      PaymentScreen(order: order)
    }
  }
  
  private func orderItemRow(_ title: String, data: String) -> some View {
    HStack {
      Text(title)
        .font(.callout)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
        .opacity(0.8)
      Text(data)
        .font(.callout)
        .fontWeight(.bold)
        .foregroundStyle(.csCream)
    }
    .listRowInsets(
      EdgeInsets(top: 25, leading: 15, bottom: 22, trailing: 15)
    )
  }
  
  private var confirmationFooterView: some View {
    VStack(spacing: 10) {
      Button {
        dismiss()
      } label: {
        ButtonLabelWithIcon(
          "Edit",
          icon: "slider.horizontal.3",
          textColor: .csCream,
          pouring: .black
        )
      }
      Button {
        isShownPaymentScreen.toggle()
      } label: {
        ButtonLabelWithIcon(
          "Confirm",
          icon: "checkmark.circle.fill",
          textColor: .white,
          pouring: .csGreen
        )
      }
    }
    .background(
      RoundedRectangle(cornerRadius: 35)
        .fill(Color.csBlack)
        .ignoresSafeArea(.all)
        .frame(height: 160)
        .shadow(radius: 5)
    )
  }
}

#Preview {
  OrderSummaryScreen(order: MockData.order)
}
