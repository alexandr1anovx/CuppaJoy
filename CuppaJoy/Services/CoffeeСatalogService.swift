//
//  CoffeeService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 24.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

// MARK: - Coffee Catalog Service Protocol

protocol CoffeeCatalogServiceProtocol {
  func fetchCoffees() async throws -> [Coffee]
}

final class CoffeeCatalogService: CoffeeCatalogServiceProtocol {
  
  private let db = Firestore.firestore()
  private let coffeesCollection: String = "coffees"
  
  init() {
    print("✅ СoffeeCatalogService INITIALIZED")
  }
  deinit {
    print("❌ СoffeeCatalogService DEINITIALIZED")
  }
  
  func fetchCoffees() async throws -> [Coffee] {
    let snapshot = try await db
      .collection(coffeesCollection)
      .getDocuments()
    let coffees = try snapshot.documents.compactMap { document in
      try document.data(as: Coffee.self)
    }
    return coffees
  }
}
