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
  
  @Published var favoriteConfigs: [CoffeeConfig] = []
  @Published var alertItem: AlertItem?
  private let configService = CoffeeConfigService.shared
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    Task { await setupBindings() }
  }
  
  // MARK: - Public Methods
  
  func fetchFavoriteConfigs() async {
    do {
      try await configService.fetchFavoriteConfigs()
    } catch {
      print("⚠️ Failed to fetch favorite configs: \(error.localizedDescription)")
    }
  }
  
  func saveFavoriteConfig(_ config: CoffeeConfig) async {
    configService.saveFavoriteConfig(config)
  }
  
  func deleteFavoriteConfig(_ config: CoffeeConfig) async {
    do {
      try await configService.deleteFavoriteConfig(config)
      alertItem = ConfigAlertContext.configDeletionSuccess
    } catch {
      alertItem = ConfigAlertContext.configDeletionFailed
    }
  }
  
  // MARK: - Private Methods
  private func setupBindings() async {
    do {
      try await configService.fetchFavoriteConfigs()
      Timer.publish(every: 0.5, on: .main, in: .common)
        .autoconnect()
        .sink { [weak self] _ in
          guard let self = self else { return }
          self.favoriteConfigs = self.configService.favoriteConfigs
        }
        .store(in: &cancellables)
    } catch {
      print("⚠️ Cannot setup bindings")
    }
  }
}
