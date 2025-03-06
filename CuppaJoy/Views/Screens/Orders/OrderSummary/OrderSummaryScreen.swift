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
  
  @State private var visibleIndices: Set<Int> = []
  
  var orderDetails: [(String, String)] {
    [
      ("Coffee", order.coffee),
      ("Size", order.cupSize),
      ("Count", "\(order.cupCount)"),
      ("Sugar sticks", "\(order.sugarSticks)"),
      ("Ice cubes", "\(order.iceCubes)"),
      ("Variety", order.variety),
      ("Milk", order.milk),
      ("Flavor", order.flavor)
    ]
  }

  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        List(Array(orderDetails.enumerated()), id: \.offset) { index, item in
          orderItemRow(item.0, data: item.1)
            .opacity(visibleIndices.contains(index) ? 1:0)
            .offset(y: visibleIndices.contains(index) ? 0:5)
            .animation(.easeInOut.delay(Double(index) * 0.15), value: visibleIndices)
            .onAppear {
              visibleIndices.insert(index)
            }
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(10)
        .environment(\.defaultMinListRowHeight, 46)
        .scrollContentBackground(.hidden)
        .shadow(radius: 5)
        
        confirmationStack
      }
    }
    .navigationTitle("Order Summary")
    .fullScreenCover(isPresented: $isShownPaymentScreen) {
      PaymentScreen(order: order)
    }
  }
  
  private func orderItemRow(_ title: String, data: String) -> some View {
    HStack {
      Text("\(title):")
        .font(.subheadline)
        .fontWeight(.semibold)
        .foregroundStyle(.white)
        .opacity(0.9)
      Text(data)
        .font(.callout)
        .fontWeight(.bold)
        .foregroundStyle(.csCream)
    }
  }
  
  private var confirmationStack: some View {
    VStack(spacing: 10) {
      Button {
        dismiss()
      } label: {
        ButtonLabelWithIcon(
          "Edit",
          icon: "slider.horizontal.3",
          textColor: .white,
          pouring: .black
        )
      }
      Button {
        isShownPaymentScreen.toggle()
      } label: {
        ButtonLabelAnimated(
          "Confirm for \(order.stringPrice)",
          textColor: .white,
          bgColor: Color.buttonGradient
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
