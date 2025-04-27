//
//  CoffeeConfig.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation

struct CoffeeConfig: Identifiable, Hashable, Codable {
  let id: String
  let title: String
  let cupSize: String
  let sugarSticks: Int
  let iceCubes: Int
  let variety: String
  let milk: String
  let flavor: String
}
