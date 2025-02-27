//
//  CoffeeViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation
import FirebaseFirestore

final class CoffeeViewModel: ObservableObject {
  
  // MARK: Properties
  @Published var coffees: [Coffee] = [
    Coffee(id: "1", title: "Americano", description: "Americano description", rating: 4.5, price: 30),
    Coffee(id: "2", title: "Espresso", description: "Espresso description", rating: 4.0, price: 25),
    Coffee(id: "3", title: "Lattee", description: "Latte description", rating: 4.2, price: 29),
    Coffee(id: "4", title: "Cappuccino", description: "Cappuccino description", rating: 5, price: 20)
  ]
  private let coffeeCollection = Firestore.firestore().collection("coffees")
  
  // MARK: Public Methods
  func retrieveCoffees() {
    coffeeCollection.addSnapshotListener { snapshot, error in
      if let error {
        print(error.localizedDescription)
        return
      }
      guard let documents = snapshot?.documents else {
        print("Cannnot retrieve documents from firestore")
        return
      }
      // Fill in the coffee's array
      self.coffees = documents.map { snapshot -> Coffee in
        let data = snapshot.data()
        let id = snapshot.documentID
        let title = data["title"] as? String ?? ""
        let description = data["description"] as? String ?? ""
        let rating = data["rating"] as? Double ?? 0.0
        let price = data["price"] as? Double ?? 0.0
        
        return Coffee(
          id: id,
          title: title,
          description: description,
          rating: rating,
          price: price
        )
      }
    }
  }
}
