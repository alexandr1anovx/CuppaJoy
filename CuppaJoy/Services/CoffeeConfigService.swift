//
//  CoffeeConfigService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 25.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

enum ConfigServiceError: Error {
  case userNotLoggedIn
  case missingConfigID
}

// MARK: - Coffee Config Service Protocol

protocol CoffeeConfigServiceProtocol {
  func fetchConfigs() -> AsyncStream<Result<[CoffeeConfig], Error>>
  func saveConfig(_ config: CoffeeConfig) async throws
  func deleteConfig(_ config: CoffeeConfig) async throws
}

final class CoffeeConfigService: CoffeeConfigServiceProtocol {
  
  private let db = Firestore.firestore()
  private var configsListener: ListenerRegistration?
  private let usersCollection: String = "users"
  private let configsCollection: String = "configs"
  
  // MARK: - Public Methods
  
  func fetchConfigs() -> AsyncStream<Result<[CoffeeConfig], Error>> {
    return AsyncStream { continuation in
      guard let uid = Auth.auth().currentUser?.uid else {
        continuation.yield(.failure(AuthErrorCode.nullUser))
        continuation.finish()
        return
      }
      let listener = configsCollection(forUserID: uid)
        .addSnapshotListener { snapshot, error in
          if let error {
            continuation.yield(.failure(error))
            return
          }
          guard let documents = snapshot?.documents else {
            continuation.yield(.success([]))
            return
          }
          let configs = documents.compactMap {
            try? $0.data(as: CoffeeConfig.self)
          }
          continuation.yield(.success(configs))
        }
      
      continuation.onTermination = { @Sendable _ in
        listener.remove()
      }
    }
  }
  
  func saveConfig(_ config: CoffeeConfig) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw ConfigServiceError.userNotLoggedIn
    }
    try configsCollection(forUserID: uid)
      .document(config.uid)
      .setData(from: config)
  }
  
  func deleteConfig(_ config: CoffeeConfig) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw ConfigServiceError.userNotLoggedIn
    }
    try await configsCollection(forUserID: uid)
      .document(config.uid)
      .delete()
  }
  
  // MARK: - Private Methods
  
  private func configsCollection(forUserID uid: String) -> CollectionReference {
    return db
      .collection(usersCollection)
      .document(uid)
      .collection(configsCollection)
  }
}
