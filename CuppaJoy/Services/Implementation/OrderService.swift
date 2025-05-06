//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import Foundation
import FirebaseAuth

final class OrderService: OrderServiceProtocol {
  
  // MARK: Properties
  
  var ongoingOrders: [Order] = []
  var receivedOrders: [Order] = []
  private let authService = AuthService.shared
  
  // MARK: Private Initializer
  
  static let shared = OrderService()
  private init() {}
  
  // MARK: - Ongoing Orders
  
  func getOngoingOrders() {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️ Failed to get user ID.")
      return
    }
    authService.userCollection.document(uid).collection("orders")
      .whereField("status", isEqualTo: "ongoing")
      .addSnapshotListener { [weak self] snapshot, error in
        guard let self = self else { return }
        
        if let error {
          print("⚠️ Error listening for documents: \(error)")
          return
        }
        guard let documents = snapshot?.documents else {
          print("⚠️ Error fetching documents: \(error!)")
          return
        }
        let newOngoingOrders = documents.compactMap { doc -> Order? in
          try? doc.data(as: Order.self)
        }
        DispatchQueue.main.async {
          self.ongoingOrders = newOngoingOrders
          self.receivedOrders.removeAll { order in
            newOngoingOrders.contains(where: { $0.id == order.id })
          }
        }
      }
  }
  
  func setOngoingOrder(_ order: Order) {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️ Failed to get user ID")
      return
    }
    let orderData: [String: Any] = [
      "id": order.id,
      "coffee": order.coffee,
      "cupSize": order.cupSize,
      "cupCount": order.cupCount,
      "sugarSticks": order.sugarSticks,
      "iceCubes": order.iceCubes,
      "variety": order.variety,
      "milk": order.milk,
      "flavor": order.flavor,
      "timestamp": order.timestamp,
      "points": order.points,
      "totalPrice": order.totalPrice,
      "status": "ongoing"
    ]
    authService.userCollection.document(uid).collection("orders").document(order.id)
      .setData(orderData) { error in
        if let error {
          print("⚠️ Error writing document: \(error)")
        } else {
          print("✅ Order document successfully updated with the new ongoing order!")
        }
      }
  }
  
  func cancelOngoingOrder(_ order: Order) {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️ Failed to get user ID.")
      return
    }
    
    self.ongoingOrders.removeAll { $0.id == order.id }
    
    authService.userCollection.document(uid).collection("orders").document(order.id)
      .delete { error in
        guard let error else {
          print("✅ Order successfully deleted from Firestore!")
          return
        }
        print("⚠️ Error deleting order: \(error.localizedDescription)")
      }
  }
  
  // MARK: - Received Orders
  
  func getReceivedOrders() {
    guard let uid = authService.currentUser?.uid else {
      print("⚠️ Failed to get user ID")
      return
    }
    authService.userCollection.document(uid).collection("orders")
      .whereField("status", isEqualTo: "received")
      .order(by: "timestamp", descending: true)
      .addSnapshotListener { [weak self] querySnapshot, error in
        guard let self = self else { return }
        
        if let error {
          print("⚠️ Error listening for documents: \(error)")
          return
        }
        guard let documents = querySnapshot?.documents else {
          print("⚠️ Failed to get the documents")
          return
        }
        let newReceivedOrders = documents.compactMap { doc -> Order? in
          try? doc.data(as: Order.self)
        }
        DispatchQueue.main.async {
          self.receivedOrders = newReceivedOrders
          self.ongoingOrders.removeAll { order in
            newReceivedOrders.contains(where: { $0.id == order.id })
          }
        }
      }
  }
}
