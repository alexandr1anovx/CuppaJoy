//
//  OrderSummaryScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import SwiftUI

struct OrderSummaryScreen: View {
  
  let order: Order
  @Binding var path: NavigationPath
  @State private var visibleIndices: Set<Int> = []
  @State private var isShownPaymentScreen = false
  
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
          row(title: item.0, content: item.1)
            .opacity(visibleIndices.contains(index) ? 1:0)
            .offset(y: visibleIndices.contains(index) ? 0:5)
            .animation(.easeInOut.delay(Double(index) * 0.15), value: visibleIndices)
            .onAppear {
              visibleIndices.insert(index)
            }
        }
        .customListStyle(rowSpacing: 10, shadowRadius: 3)
        
        confirmationStack
      }
    }
    .navigationTitle("Order Summary")
    .navigationBarTitleDisplayMode(.large)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        Button {
          path.removeLast()
        } label: {
          ReturnButtonLabel()
        }
      }
    }
  }
  
  private func row(title: String, content: String) -> some View {
    HStack {
      Text("\(title):")
        .fontWeight(.medium)
        .foregroundStyle(.white)
      Text(content)
        .foregroundStyle(.csCream)
        .fontWeight(.semibold)
    }
    .font(.subheadline)
  }
  
  private var confirmationStack: some View {
    VStack(spacing: 10) {
      Button {
        path.removeLast()
      } label: {
        ButtonLabelWithIcon(
          "Edit",
          icon: "slider.horizontal.3",
          textColor: .white,
          bgColor: .black
        )
      }
      Button {
        path.append(OrderPage.payment(order))
      } label: {
        ButtonLabelWithIcon(
          "Confirm for \(order.formattedPrice)",
          icon: "checkmark.circle.fill",
          textColor: .white,
          bgColor: .csBrown
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
  OrderSummaryScreen(
    order: MockData.order,
    path: .constant(NavigationPath())
  )
}
