//
//  CoffeeConfigProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import Foundation

protocol CoffeeConfigProtocol {
  func fetchFavoriteConfigs() async throws
  func saveFavoriteConfig(_ config: CoffeeConfig)
  func deleteFavoriteConfig(_ config: CoffeeConfig) async throws
}
