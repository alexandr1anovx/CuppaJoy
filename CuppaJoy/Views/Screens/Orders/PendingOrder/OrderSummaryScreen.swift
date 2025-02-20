//
//  OrderSummaryScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import SwiftUI

struct OrderSummaryScreen: View {
  
  // MARK: Properties
  let order: Order
  @State private var isShownPaymentScreen = false
  
  var body: some View {
    VStack {
      Text("Order Summary")
        .font(.largeTitle)
        .padding()
      
//      struct Order: Identifiable {
//        let id: String
//        let coffee: Coffee
//        let cupQuantity: Int
//        let sugarSticks: Int
//        let cupSize: CupSize
//        let coffeeType: CoffeeType
//        let milk: Milk
//        let syrup: Syrup
//        let iceCubeCount: IceCube
//        let totalPrice: Double
//      }
      
      Text("Coffee: \(order.coffee.title)")
      Text("Cup quantity: \(order.cupQuantity)")
      Text("Sugar sticks: \(order.sugarSticks)")
      Text("Cup size: \(order.cupSize)")
      Text("Coffee type: \(order.coffeeType)")
      Text("Milk: \(order.milk.title)")
      Text("Syrup: \(order.syrup.title)")
      Text("Ice cube count: \(order.iceCubeCount)")
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
