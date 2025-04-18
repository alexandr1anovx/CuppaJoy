//
//  CoffeeConfigViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

@MainActor
final class CoffeeConfigViewModel: ObservableObject {
  
  @Published var favoriteConfigs: [CoffeeConfig] = []
  
  func saveFavoriteConfig(_ config: CoffeeConfig) {
    favoriteConfigs.append(config)
  }
  func deleteFavoriteConfig(_ config: CoffeeConfig) {
    favoriteConfigs.removeAll { $0.id == config.id }
  }
}
