//
//  CoffeeConfigService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

final class CoffeeConfigService: CoffeeConfigServiceProtocol {
  
  // MARK: - Private Properites
  
  private let database = Firestore.firestore()
  private var configsListener: ListenerRegistration?
  
  // MARK: - Deinit
  
  deinit { configsListener?.remove() }
  
  // MARK: - Public Methods
  
  func fetchConfigs(completion: @escaping (Result<[CoffeeConfig], Error>) -> Void) {
    configsListener?.remove()
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("configs")
      .addSnapshotListener { snapshot, error in
        if let error {
          print("❌ Failed to fetch configs: \(error)")
          completion(.failure(error))
          return
        }
        guard let documents = snapshot?.documents else {
          print("❌ Failed to read config documents!")
          completion(.failure(
            NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "No documents found."]))
          )
          return
        }
        let configs = documents.compactMap {
          try? $0.data(as: CoffeeConfig.self)
        }
        completion(.success(configs))
        print("✅ Fetched configs: \(configs)")
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
