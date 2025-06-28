//
//  CoffeeService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 24.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

protocol CoffeeCatalogServiceProtocol {
  func fetchCoffees() async throws -> [Coffee]
}

final class CoffeeCatalogService: CoffeeCatalogServiceProtocol {
  
  private let db = Firestore.firestore()
  private let coffeeCollection: String = "coffees"
  
  func fetchCoffees() async throws -> [Coffee] {
    let snapshot = try await db
      .collection(coffeeCollection)
      .getDocuments()
    let coffees = try snapshot.documents.compactMap { document in
      try document.data(as: Coffee.self)
    }
    return coffees
  }
}
