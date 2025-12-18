//
//  CoffeeConfigViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation
import FirebaseAuth

@MainActor
final class CoffeeConfigViewModel: ObservableObject {
  
  @Published var configs: [CoffeeConfig] = []
  @Published var alertItem: AlertItem?
  
  private let coffeeConfigService: CoffeeConfigServiceProtocol
  private var subscriptionTask: Task<Void, Never>?
  
  // MARK: - Init / Deinit
  
  init(coffeeConfigService: CoffeeConfigServiceProtocol) {
    self.coffeeConfigService = coffeeConfigService
    subscribeToConfigs()
  }
  
  deinit {
    subscriptionTask?.cancel()
  }
  
  // MARK: - Public Methods
  
  func saveConfig(_ config: CoffeeConfig) async {
    do {
      try await coffeeConfigService.saveConfig(config)
    } catch {
      print("Failed to save config: \(error.localizedDescription)")
    }
  }
  
  func deleteConfig(_ config: CoffeeConfig) async {
    do {
      try await coffeeConfigService.deleteConfig(config)
    } catch {
      print("Failed to delete config: \(error.localizedDescription)")
      alertItem = Alerts.Config.deletionFailed
    }
  }
  
  // MARK: - Private Methods
  
  private func subscribeToConfigs() {
    subscriptionTask?.cancel()
    subscriptionTask = Task {
      let stream = coffeeConfigService.fetchConfigs()
      
      for await result in stream {
        switch result {
        case .success(let configs):
          self.configs = configs
          print("Configs: \(configs)")
        case .failure(let error):
          print("Failed to load favorite configs: \(error.localizedDescription)")
        }
      }
    }
  }
}
