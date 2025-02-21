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
  
  var body: some View {
    VStack {
      Text("Order Summary")
        .font(.largeTitle)
        .padding()
      
      Text("Coffee: \(order.coffee.title)")
      Text("Cup size: \(order.cupSize)")
      Text("Count: \(order.cupCount)")
      Text("Sugar sticks: \(order.sugarCount)")
      Text("Ice cubes: \(order.iceCount)")
      Text("Variety: \(order.variety)")
      Text("Milk: \(order.milk.title)")
      Text("Flavor: \(order.flavor.title)")
      Text("Total: $\(order.totalPrice, specifier: "%.2f")")
      
      Button {
        // save the order to firebase firestore
        isShownPaymentScreen.toggle()
      } label: {
        Text("Confirm Order")
          .bold()
          .padding()
          .background(.green)
          .foregroundColor(.white)
          .cornerRadius(10)
      }
    }
    .padding()
    .fullScreenCover(isPresented: $isShownPaymentScreen) {
      PaymentScreen(order: order)
    }
  }
}

#Preview {
  OrderSummaryScreen(order: MockData.order)
}
