//
//  Coffee.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import Foundation

enum Coffee: String, CaseIterable {
  case americano
  case espresso
  case latte
  case cappuccino
  
  var title: String {
    switch self {
    case .americano: "Americano"
    case .espresso: "Espresso"
    case .latte: "Latte"
    case .cappuccino: "Cappuccino"
    }
  }
  
  var price: Double {
    switch self {
    case .americano: 20.5
    case .espresso: 25.0
    case .latte: 23.0
    case .cappuccino: 28.0
    }
  }
}
