//
//  CoffeeViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation
import FirebaseFirestore

@MainActor
final class CoffeeViewModel: ObservableObject {
  
  @Published var coffees: [Coffee] = []
  
  private let coffeeCollection = Firestore.firestore().collection("coffees")
  
  // MARK: - Public Methods
  
  func getCoffees() {
    coffeeCollection.addSnapshotListener { snapshot, error in
      if let error {
        print(error.localizedDescription)
        return
      }
      guard let documents = snapshot?.documents else {
        print("Cannnot retrieve documents from firestore when calling 'getCoffees' method.")
        return
      }
      self.coffees = documents.map { snapshot -> Coffee in
        let data = snapshot.data()
        let id = snapshot.documentID
        let title = data["title"] as? String ?? ""
        let description = data["description"] as? String ?? ""
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

extension CoffeeViewModel {
  static func previewMode() -> CoffeeViewModel {
    let viewModel = CoffeeViewModel()
    viewModel.coffees = [
      Coffee(
        id: "1",
        title: "Cappuccino",
        description: "Caramelized sugar on top",
        rating: 15,
        points: 5,
        price: 25.50
      ),
      Coffee(
        id: "2",
        title: "Americano",
        description: "Caramelized sugar on bottom",
        rating: 10,
        points: 3,
        price: 15.50
      )
    ]
    return viewModel
  }
}
