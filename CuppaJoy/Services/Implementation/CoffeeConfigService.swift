//
//  CoffeeConfigService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

final class CoffeeConfigService: CoffeeConfigProtocol, ObservableObject {
  
  // MARK: Public Properites
  
  @Published var favoriteConfigs: [CoffeeConfig] = []
  
  // MARK: Private Properites
  private let database = Firestore.firestore()
  
  // MARK: - Public Methods
  
  func fetchConfigs() async throws {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("configs")
      .addSnapshotListener { [weak self] snapshot, error in
        guard let self = self else { return }
        
        if let error = error {
          print("⚠️ Error listening for documents: \(error)")
          return
        }
        guard let documents = snapshot?.documents else { return }
        
        let newConfigs = documents.compactMap { doc -> CoffeeConfig? in
          try? doc.data(as: CoffeeConfig.self)
        }
        DispatchQueue.main.async {
          self.favoriteConfigs = newConfigs
        }
      }
  }
  
  func saveConfig(_ config: CoffeeConfig) async throws {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
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
    
    try await database
      .collection("users")
      .document(uid)
      .collection("configs")
      .document(config.id)
      .setData(configData)
  }
  
  func deleteConfig(_ config: CoffeeConfig) async throws {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    try await database
      .collection("users")
      .document(uid)
      .collection("configs")
      .document(config.id)
      .delete()
  }
}
