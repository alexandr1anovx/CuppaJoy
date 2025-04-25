//
//  CoffeeService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 24.04.2025.
//

import Foundation
import FirebaseFirestore

final class CoffeeСatalogService: CoffeeCatalogServiceProtocol {
  
  var coffees: [Coffee] = []
  private let collection = Firestore.firestore().collection("coffees")
  
  static let shared = CoffeeСatalogService()
  private init() {}
  
  // MARK: Public Methods
  
  func fetchCoffees() async throws {
    collection.addSnapshotListener { snapshot, error in
      if let error = error {
        print("⚠️ Failed to fetch coffees: \(error.localizedDescription)")
      }
      
      guard let documents = snapshot?.documents else {
        print("⚠️ Failed to fetch coffees: No documents found.")
        return
      }
      
      self.coffees = documents.map { snapshot -> Coffee in
        let data = snapshot.data()
        let id = snapshot.documentID
        let title = data["title"] as? String ?? "No title"
        let description = data["description"] as? String ?? "No description"
        let rating = data["rating"] as? Double ?? 0.0
        let points = data["points"] as? Int ?? 0
        let price = data["price"] as? Double ?? 0.0
        
        return Coffee(
          id: id,
          title: title,
          description: description,
          rating: rating,
          points: points,
          price: price
        )
      }
    }
  }
}
