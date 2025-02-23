//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation

final class OrderViewModel: ObservableObject {
  
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  func addOrder(_ order: Order) {
    ongoingOrders.append(order)
  }
  
  func cancelOrder(_ order: Order) {
    // the item ID creation will be changed in the future.
    ongoingOrders.removeAll { $0.id == order.id }
  }
  
  func retrieveOrders() {
    // fill the orders array with the user's order history.
  }
  
}
