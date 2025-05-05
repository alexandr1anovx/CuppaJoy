//
//  CoffeeConfigViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation
import Combine

@MainActor
final class CoffeeConfigViewModel: ObservableObject {
  
  @Published var configs: [CoffeeConfig] = []
  private let configService = CoffeeConfigService.shared
  private var cancellables = Set<AnyCancellable>()
  @Published var alertItem: AlertItem?
  
  private func setupBindings() async {
    do {
      try await configService.fetchConfigs()
      Timer.publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
        .sink { [weak self] _ in
          guard let self = self else { return }
          self.configs = self.configService.configs
        }
        .store(in: &cancellables)
    } catch {
      print("⚠️ Cannot setup bindings")
    }
  }
  
  func fetchConfigs() async {
    do {
      try await configService.fetchConfigs()
    } catch {
      print("⚠️ Failed to fetch user configs: \(error.localizedDescription)")
    }
  }
  
  func saveFavoriteConfig(_ config: CoffeeConfig) {
    configs.append(config)
  }
  
  func deleteFavoriteConfig(_ config: CoffeeConfig) async {
    do {
      try await configService.deleteConfig(config)
      alertItem = ConfigAlertContext.configDeletionSuccess
    } catch {
      alertItem = ConfigAlertContext.configDeletionFailed
    }
  }
}
