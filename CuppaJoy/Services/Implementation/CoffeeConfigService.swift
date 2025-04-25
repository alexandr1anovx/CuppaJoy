//
//  CoffeeConfigService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import Foundation

final class CoffeeConfigService: CoffeeConfigProtocol {
  
  // MARK: Private Properites
  
  var configs: [CoffeeConfig] = []
  private let authService = AuthService.shared
  
  // MARK: - Private Initializer
  
  static let shared = CoffeeConfigService()
  private init() {}
  
  // MARK: - Public Methods
  
  func fetchConfigs() async throws {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️Failed to get user ID")
      return
    }
    authService.userCollection.document(uid).collection("configs")
      .addSnapshotListener { [weak self] snapshot, error in
        guard let self = self else { return }
        
        if let error {
          print("⚠️ Error listening for documents: \(error)")
          return
        }
        guard let documents = snapshot?.documents else {
          print("⚠️ Error fetching documents: \(error!)")
          return
        }
        let newConfigs = documents.compactMap { doc -> CoffeeConfig? in
          try? doc.data(as: CoffeeConfig.self)
        }
        DispatchQueue.main.async {
          self.configs = newConfigs
        }
      }
  }
  
  func saveConfigs(_ config: CoffeeConfig) async {
    configs.append(config)
  }
  
  func deleteConfig(_ config: CoffeeConfig) async {
    configs.removeAll { $0.id == config.id }
  }
}
