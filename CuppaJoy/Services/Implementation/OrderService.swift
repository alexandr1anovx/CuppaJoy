//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class OrderService: OrderServiceProtocol, ObservableObject {
  
  // MARK: Public Properties
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  // MARK: Private Properties
  private let database = Firestore.firestore()
  
  // MARK: - Public Methods
  
  func getOngoingOrders() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("orders")
      .whereField("status", isEqualTo: "ongoing")
      .addSnapshotListener { [weak self] snapshot, error in
        if let error = error {
          print("⚠️ Failed to fetch ongoing orders: \(error.localizedDescription)")
        }
        guard let self = self else { return }
        print("‼️ SELF: \(self)")
        guard let documents = snapshot?.documents else { return }
        print("‼️ DOCUMENTS: \(documents)")
        let orders = documents.compactMap {
          try? $0.data(as: Order.self)
        }
        DispatchQueue.main.async {
          self.ongoingOrders = orders
        }
      }
  }
  
  func getReceivedOrders() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("orders")
      .whereField("status", isEqualTo: "received")
      .addSnapshotListener { [weak self] snapshot, error in
        if let error = error {
          print("⚠️ Failed to fetch ongoing orders: \(error.localizedDescription)")
        }
        guard let self = self else { return }
        print("‼️ SELF: \(self)")
        guard let documents = snapshot?.documents else { return }
        print("‼️ DOCUMENTS: \(documents)")
        let orders = documents.compactMap {
          try? $0.data(as: Order.self)
        }
        DispatchQueue.main.async {
          self.receivedOrders = orders
        }
      }
  }
  
  func setOngoingOrder(_ order: Order) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
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
    database
      .collection("users")
      .document(uid)
      .collection("orders")
      .document(order.id)
      .setData(orderData) { error in
        if let error {
          print("DEBUG ⚠️: Cannot set ongoing order: \(error.localizedDescription)")
        } else {
          print("✅ Ongoing order has been added!")
        }
      }
  }
  
  func cancelOngoingOrder(_ order: Order) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("orders")
      .document(order.id)
      .delete { error in
        if let error = error {
          print("DEBUG ⚠️: Cannot delete ongoing order: \(error.localizedDescription)")
        }
      }
  }
}
