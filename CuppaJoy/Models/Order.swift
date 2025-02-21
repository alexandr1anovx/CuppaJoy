//
//  Order.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation

struct Order: Identifiable {
  let id: String
  let coffee: Coffee
  let cupSize: CupSize
  let cupCount: Int
  let sugarCount: Int
  let iceCount: Int
  let variety: Variety
  let milk: Milk
  let flavor: Flavor
  
  var totalPrice: Double {
    let basePrice = coffee.price
    let configurations = cupSize.price + milk.price + flavor.price
    let total = (basePrice + configurations) * Double(cupCount)
    return total
  }
}

struct MockData {
  static let order: Order = Order(
    id: "123",
    coffee: .americano,
    cupSize: .medium,
    cupCount: 1,
    sugarCount: 2,
    iceCount: 1,
    variety: .arabica,
    milk: .none,
    flavor: .vanilla
  )
}
