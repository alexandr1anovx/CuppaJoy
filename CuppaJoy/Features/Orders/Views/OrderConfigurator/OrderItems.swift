//
//  OrderItems.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation

protocol OrderItemType: CaseIterable, Hashable {
  var id: String { get }
  var title: String { get }
  var price: Double { get }
}

enum CupSize: String, OrderItemType {
  case small
  case medium
  case large
  
  var id: String { rawValue }
  var title: String { rawValue.capitalized }
  
  var price: Double {
    switch self {
    case .small: CoffeePrices.CupSize.small
    case .medium: CoffeePrices.CupSize.medium
    case .large: CoffeePrices.CupSize.large
    }
  }
}

enum Variety: String, OrderItemType {
  case standart
  case arabica
  case robusta
  case excelsa
  case liberica
  
  var id: String { rawValue }
  var title: String { rawValue.capitalized }
  
  var price: Double {
    switch self {
    case .standart: CoffeePrices.Variety.standart
    case .arabica: CoffeePrices.Variety.arabica
    case .robusta: CoffeePrices.Variety.robusta
    case .excelsa: CoffeePrices.Variety.excelsa
    case .liberica: CoffeePrices.Variety.liberica
    }
  }
}

enum Milk: String, OrderItemType {
  case none
  case lactose
  
  var id: String { rawValue }
  var title: String { rawValue.capitalized }
  
  var price: Double {
    switch self {
    case .none: CoffeePrices.Milk.none
    case .lactose: CoffeePrices.Milk.lactose
    }
  }
}

enum Flavor: String, OrderItemType {
  case none
  case vanilla
  case caramel
  case coconut
  
  var id: String { rawValue }
  var title: String { rawValue.capitalized }
  
  var price: Double {
    switch self {
    case .none: CoffeePrices.Flavor.none
    case .coconut: CoffeePrices.Flavor.coconut
    case .vanilla: CoffeePrices.Flavor.vanilla
    case .caramel: CoffeePrices.Flavor.caramel
    }
  }
}
