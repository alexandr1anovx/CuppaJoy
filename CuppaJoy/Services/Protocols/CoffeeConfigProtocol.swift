//
//  CoffeeConfigProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import Foundation

protocol CoffeeConfigProtocol {
  func fetchConfigs() async throws
  func saveConfigs(_ config: CoffeeConfig) async throws
  func deleteConfig(_ config: CoffeeConfig) async throws
}
