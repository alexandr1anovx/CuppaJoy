//
//  CoffeeConfigService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

final class CoffeeConfigService: CoffeeConfigProtocol {
  
  var favoriteConfigs: [CoffeeConfig] = []
  
  // MARK: Private Properites
  private let authService = AuthService.shared
  
  // MARK: - Private Initializer
  
  static let shared = CoffeeConfigService()
  private init() {}
  
  // MARK: - Public Methods
  
  func fetchFavoriteConfigs() async throws {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️ Failed to get user ID")
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
          self.favoriteConfigs = newConfigs
        }
      }
  }
  
  
  func saveFavoriteConfig(_ config: CoffeeConfig) {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️Failed to get user ID")
      return
    }
    
    let configData: [String: Any] = [
      "id": config.id,
      "title": config.title,
      "cupSize": config.cupSize,
      "sugarSticks": config.sugarSticks,
      "iceCubes": config.iceCubes,
      "variety": config.variety,
      "milk": config.milk,
      "flavor": config.flavor
    ]
    
    authService.userCollection.document(uid).collection("configs").document(config.id)
      .setData(configData) { error in
        if let error {
          print("⚠️ Failed to save favorite config: \(error)")
        } else {
          print("✅ Order document successfully updated with the new config!")
        }
      }
  }
  
  func deleteFavoriteConfig(_ config: CoffeeConfig) async throws {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️ Failed to get user ID")
      throw NSError(
        domain: "CoffeeConfigService",
        code: 1,
        userInfo: [NSLocalizedDescriptionKey: "User not authenticated"]
      )
    }
    let userDocument = authService.userCollection.document(uid)
    try await userDocument.collection("configs").document(config.id).delete()
  }
}
