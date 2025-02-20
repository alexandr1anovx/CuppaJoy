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
  let cupQuantity: Int
  let sugarSticks: Int
  let cupSize: CupSize
  let coffeeType: CoffeeType
  let milk: Milk
  let syrup: Syrup
  let iceCubeCount: IceCube
  let totalPrice: Double
}

struct MockData {
  static let order: Order = Order(
    id: "123",
    coffee: .americano,
    cupQuantity: 1,
    sugarSticks: 2,
    cupSize: .medium,
    coffeeType: .arabica,
    milk: .none,
    syrup: .vanilla,
    iceCubeCount: .none,
    totalPrice: 50.3
  )
}
