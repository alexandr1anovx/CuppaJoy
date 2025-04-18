//
//  CoffeeConfig.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation

struct CoffeeConfig: Identifiable, Hashable {
  let id = UUID().uuidString
  let title: String
  let cupSize: CupSize
  let sugarSticks: Int
  let iceCubes: Int
  let variety: Variety
  let milk: Milk
  let flavor: Flavor
}
