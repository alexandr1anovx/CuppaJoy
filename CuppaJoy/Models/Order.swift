//
//  Order.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation

struct Order: Identifiable {
  let id: String
  let coffee: CoffeeType
  let cupSize: CupSize
  let cupCount: Int
  let sugarSticks: Int
  let iceCount: Int
  let variety: Variety
  let milk: Milk
  let flavor: Flavor
  let timestamp: Date
  
  var totalPrice: Double {
    let basePrice = coffee.price
    let configurations = cupSize.price + milk.price + flavor.price
    let total = (basePrice + configurations) * Double(cupCount)
    return total
  }
  
  var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy, HH:mm"
    return formatter.string(from: timestamp)
  }
}

struct MockData {
  static let order: Order = Order(
    id: "123",
    coffee: .americano,
    cupSize: .medium,
    cupCount: 1,
    sugarSticks: 2,
    iceCount: 1,
    variety: .arabica,
    milk: .none,
    flavor: .vanilla,
    timestamp: Date()
  )
}
