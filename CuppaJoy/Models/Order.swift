//
//  Order.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation

struct Order: Identifiable, Codable {
  let id: String
  let coffee: String
  let cupSize: String
  let cupCount: Int
  let sugarSticks: Int
  let iceCubes: Int
  let variety: String
  let milk: String
  let flavor: String
  let timestamp: Date
  var totalPrice: Double
  
  var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy, HH:mm"
    return formatter.string(from: timestamp)
  }
}

struct MockData {
  static let order: Order = Order(
    id: "123",
    coffee: "Americano",
    cupSize: "Medium",
    cupCount: 1,
    sugarSticks: 2,
    iceCubes: 0,
    variety: "Arabica",
    milk: "Lactose",
    flavor: "Caramel",
    timestamp: .now,
    totalPrice: 35.20
  )
  
  static let coffee: Coffee = Coffee(
    id: "10",
    title: "Americano",
    description: "Americano's description",
    rating: 4.5,
    price: 28.0
  )
}
