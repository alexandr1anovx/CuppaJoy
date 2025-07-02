//
//  MockData.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.02.2025.
//

import Foundation

struct MockData {
  
  static let order = Order(
    uid: "1",
    coffee: "Americano",
    cupSize: "Medium",
    cupCount: 1,
    sugarSticks: 2,
    iceCubes: 0,
    variety: "Arabica",
    milk: "Lactose",
    flavor: "Caramel",
    points: 10,
    totalPrice: 35.20,
    timestamp: .now,
    status: "ongoing"
  )
  
  static let coffee = Coffee(
    uid: "2",
    title: "Americano",
    description: "Americano's description",
    rating: 4.5,
    points: 15,
    price: 28.0
  )
  
  static let user = User(
    uid: "3",
    fullName: "Alexander Andrianov",
    email: "an4lex@gmail.com",
    city: "Mykolaiv",
    coins: 20
  )
  
  static let coffeeConfigAmericano = CoffeeConfig(
    uid: "1",
    title: "Americano",
    cupSize: "Medium",
    sugarSticks: 2,
    iceCubes: 1,
    variety: "Robusta",
    milk: "Lactose",
    flavor: "Caramel"
  )
  static let coffeeConfigLatte = CoffeeConfig(
    uid: "2",
    title: "Latte",
    cupSize: "Large",
    sugarSticks: 0,
    iceCubes: 1,
    variety: "Excelsa",
    milk: "Lactose",
    flavor: "Vanilla"
  )
}
