//
//  CoffeeConfigProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

protocol CoffeeConfigServiceProtocol {
  func fetchConfigs(completion: @escaping (Result<[CoffeeConfig], Error>) -> Void)
  func saveConfig(_ config: CoffeeConfig) async throws
  func deleteConfig(_ config: CoffeeConfig) async throws
}
