//
//  CoffeeConfigProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

protocol CoffeeConfigProtocol {
  func getConfigs()
  func saveConfig(_ config: CoffeeConfig) async throws
  func deleteConfig(_ config: CoffeeConfig) async throws
}
