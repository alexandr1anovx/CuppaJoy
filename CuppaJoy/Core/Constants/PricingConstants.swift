//
//  PricingConstants.swift
//  CuppaJoy
//
//  Created by Oleksandr Andrianov on 18.12.2025.
//

import Foundation

enum CoffeePrices {
  enum CupSize {
    static let small: Double = 0.0
    static let medium: Double = 1.5
    static let large: Double = 3.0
  }
  
  enum Variety {
    static let standart: Double = 0.0
    static let arabica: Double = 1.0
    static let robusta: Double = 1.0
    static let excelsa: Double = 2.0
    static let liberica: Double = 2.0
  }
  
  enum Milk {
    static let none: Double = 0.0
    static let lactose: Double = 3.0
  }
  
  enum Flavor {
    static let none: Double = 0.0
    static let vanilla: Double = 1.0
    static let caramel: Double = 2.0
    static let coconut: Double = 1.5
  }
}
