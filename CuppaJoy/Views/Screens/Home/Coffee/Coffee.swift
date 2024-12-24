//
//  Coffee.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import Foundation

enum Coffee: String, CaseIterable {
  case americano = "Americano"
  case espresso = "Espresso"
  case latte = "Latte"
  case cappuccino = "Cappuccino"
  case flatWhite = "Flat White"
  case mocha = "Mocha"
}

enum CoffeeCup: CaseIterable {
  case small, medium, large
  
  var ml: String {
    switch self {
    case .small: "250"
    case .medium: "350"
    case .large: "450"
    }
  }
  var price: Double {
    switch self {
    case .small: 30.50
    case .medium: 32.50
    case .large: 35.50
    }
  }
}
