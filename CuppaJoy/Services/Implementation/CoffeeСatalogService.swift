//
//  CoffeeService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 24.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

final class CoffeeCatalogService: CoffeeCatalogServiceProtocol {
  
  // MARK: - Private Properties
  
  private let database = Firestore.firestore()
  private var listener: ListenerRegistration?
  
  // MARK: - Deinitialization
  deinit { listener?.remove() }
  
  // MARK: - Public Methods
  
  func getCoffees(completion: @escaping (Result<[Coffee], Error>) -> Void) {
    listener?.remove()
    
    listener = database
      .collection("coffees")
      .addSnapshotListener { snapshot, error in
        if let error {
          print("❌ Failed to get coffees: \(error)")
          completion(.failure(error))
          return
        }
        guard let documents = snapshot?.documents else {
          print("❌ Failed to read coffee documents!")
          completion(.failure(NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "No documents found."])))
          return
        }
        let coffees = documents.compactMap {
          try? $0.data(as: Coffee.self)
        }
        completion(.success(coffees))
        print("✅ COFFEESS: \(coffees)")
      }
  }
}
