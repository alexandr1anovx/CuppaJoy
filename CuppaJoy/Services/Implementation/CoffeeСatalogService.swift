//
//  CoffeeService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 24.04.2025.
//

import FirebaseFirestore
import FirebaseAuth

final class CoffeeСatalogService: CoffeeCatalogServiceProtocol, ObservableObject {
  
  // MARK: Public Properties
  @Published var coffees: [Coffee] = []
  
  // MARK: Private Properties
  private let database = Firestore.firestore()
  private var listener: ListenerRegistration?
  
  // MARK: Deinitialization
  deinit { listener?.remove() }
  
  // MARK: Public Methods
  
  func getCoffees() {
    listener?.remove()
    
    listener = database
      .collection("coffees")
      .addSnapshotListener { [weak self] snapshot, error in
        if let error = error {
          print("⚠️ Failed to get coffees: \(error)")
        }
        guard let self = self else { return }
        guard let documents = snapshot?.documents else { return }
        let coffees = documents.compactMap {
          try? $0.data(as: Coffee.self)
        }
        DispatchQueue.main.async {
          self.coffees = coffees
        }
      }
  }
}
