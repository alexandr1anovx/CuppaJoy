//
//  CoffeeConfigViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation

@MainActor
final class CoffeeConfigViewModel: ObservableObject {
  
  // MARK: Public Properties
  @Published var favoriteConfigs: [CoffeeConfig] = []
  @Published var alertItem: AlertItem?
  
  // MARK: Private Properties
  private let coffeeConfigService: CoffeeConfigService
  
  // MARK: Initializer
  init(coffeeConfigService: CoffeeConfigService =  CoffeeConfigService()) {
    self.coffeeConfigService = coffeeConfigService
    setupBindings()
    getConfigs()
  }
  
  // MARK: - Public Methods
  func getConfigs() {
    coffeeConfigService.getConfigs()
  }
  
  func saveConfig(_ config: CoffeeConfig) async {
    do {
      try await coffeeConfigService.saveConfig(config)
    } catch {
      print("‼️ Cannot save config: \(error)")
    }
  }
  
  func deleteConfig(_ config: CoffeeConfig) async {
    do {
      try await coffeeConfigService.deleteConfig(config)
    } catch {
      alertItem = ConfigAlertContext.configDeletionFailed
    }
  }
  
  // MARK: - Private Methods
  private func setupBindings() {
    coffeeConfigService.$favoriteConfigs
      .receive(on: DispatchQueue.main)
      .assign(to: &$favoriteConfigs)
  }
}
