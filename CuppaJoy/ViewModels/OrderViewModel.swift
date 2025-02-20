//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation

final class OrderViewModel: ObservableObject {
  @Published var orders: [Order] = []
  
  func addOrder(_ order: Order) {
    orders.append(order)
  }
  
  func retrieveOrders() {
    // fill the orders array with the user's order history.
  }
  
}
