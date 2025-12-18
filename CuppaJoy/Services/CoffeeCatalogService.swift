//
//  CoffeeService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 24.04.2025.
//

import Firebase

protocol CoffeeCatalogServiceProtocol {
  func fetchCoffees() async throws -> [Coffee]
}

final class CoffeeCatalogService: CoffeeCatalogServiceProtocol {
  private var db = Firestore.firestore()
  
  func fetchCoffees() async throws -> [Coffee] {
    let snapshot = try await db
      .collection(FirestoreCollection.coffees)
      .getDocuments()
    let coffees = try snapshot.documents.compactMap { document in
      try document.data(as: Coffee.self)
    }
    return coffees
  }
}
