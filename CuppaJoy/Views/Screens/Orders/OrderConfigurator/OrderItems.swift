//
//  Additives.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation

protocol OrderItemType: CaseIterable, Hashable {
  var title: String { get }
  var price: Double { get }
}

enum CupSize: String, OrderItemType {
  case small, medium, large
  
  var title: String { rawValue.capitalized }
  var price: Double {
    switch self {
    case .small: 0.0
    case .medium: 1.5
    case .large: 3.0
    }
  }
}

enum Variety: String, OrderItemType {
  case standart, arabica, robusta, excelsa, liberica
  
  var title: String { rawValue.capitalized }
  var price: Double {
    switch self {
    case .standart: 0.0
    case .arabica: 1.0
    case .robusta: 1.0
    case .excelsa: 2.0
    case .liberica: 2.0
    }
  }
}

enum Milk: String, OrderItemType {
  case none, lactose
  
  var title: String {
    switch self {
    case .none: "None"
    case .lactose: "Lactose"
    }
  }
  var price: Double {
    switch self {
    case .none: 0.0
    case .lactose: 3.0
    }
  }
}

enum Flavor: String, OrderItemType {
  case none, vanilla, caramel, coconut
  
  var title: String {
    switch self {
    case .none: "None"
    case .vanilla: "Vanilla"
    case .caramel: "Caramel"
    case .coconut: "Coconut"
    }
  }
  var price: Double {
    switch self {
    case .none: 0.0
    case .coconut: 1.5
    case .vanilla: 1.0
    case .caramel: 2.0
    }
  }
}
