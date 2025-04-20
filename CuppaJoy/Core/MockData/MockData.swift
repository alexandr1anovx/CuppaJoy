//
//  MockData.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.02.2025.
//

import Foundation

struct MockData {
  
  static let order = Order(
    id: "1",
    coffee: "Americano",
    cupSize: "Medium",
    cupCount: 1,
    sugarSticks: 2,
    iceCubes: 0,
    variety: "Arabica",
    milk: "Lactose",
    flavor: "Caramel",
    timestamp: .now,
    points: 10,
    totalPrice: 35.20
  )
  
  static let coffee = Coffee(
    id: "2",
    title: "Americano",
    description: "Americano's description",
    rating: 4.5,
    points: 15,
    price: 28.0
  )
  
  static let user = User(
    id: "3",
    fullName: "Alexander Andrianov",
    emailAddress: "an4lex@gmail.com",
    city: "Mykolaiv",
    coins: 20
  )
  
  static let config = CoffeeConfig(
    title: "Americano",
    cupSize: .medium,
    sugarSticks: 2,
    iceCubes: 1,
    variety: .robusta,
    milk: .lactose,
    flavor: .caramel
  )
  static let config2 = CoffeeConfig(
    title: "Latte",
    cupSize: .large,
    sugarSticks: 0,
    iceCubes: 1,
    variety: .excelsa,
    milk: .lactose,
    flavor: .vanilla
  )
}
