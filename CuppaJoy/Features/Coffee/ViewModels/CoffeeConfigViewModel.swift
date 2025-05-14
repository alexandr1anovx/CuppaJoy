//
//  CoffeeConfigViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation

@MainActor
final class CoffeeConfigViewModel: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var favoriteConfigs: [CoffeeConfig] = []
  @Published var alertItem: AlertItem?
  
  // MARK: - Private Properties
  
  private let coffeeConfigService: CoffeeConfigService
  
  // MARK: - Init
  
  init(coffeeConfigService: CoffeeConfigService =  CoffeeConfigService()) {
    self.coffeeConfigService = coffeeConfigService
    fetchConfigs()
  }
  
  // MARK: - Public Methods
  
  func fetchConfigs() {
    coffeeConfigService.fetchConfigs { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let configs):
          self?.favoriteConfigs = configs
        case .failure(let error):
          print("❌ Failed to fetch configs: \(error.localizedDescription)")
        }
      }
    }
  }
  
  func saveConfig(_ config: CoffeeConfig) async {
    do {
      try await coffeeConfigService.saveConfig(config)
    } catch {
      print("❌ Failed to save config: \(error.localizedDescription)")
    }
  }
  
  func deleteConfig(_ config: CoffeeConfig) async {
    do {
      try await coffeeConfigService.deleteConfig(config)
    } catch {
      alertItem = ConfigAlertContext.configDeletionFailed
    }
  }
}

extension CoffeeConfigViewModel {
  static var previewMode: CoffeeConfigViewModel {
    let viewModel = CoffeeConfigViewModel()
    viewModel.favoriteConfigs = [MockData.coffeeConfigLatte, MockData.coffeeConfigAmericano]
    return viewModel
  }
}
