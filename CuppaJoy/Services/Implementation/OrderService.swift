//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

final class OrderService: OrderServiceProtocol {
  
  // MARK: Public Properties
  var ongoingOrders: [Order] = []
  var receivedOrders: [Order] = []
  
  // MARK: Private Properties
  private let database = Firestore.firestore()
  
  // MARK: Private Initializer
  static let shared = OrderService()
  private init() {}
  
  // MARK: - Ongoing Orders
  
  func getOngoingOrders() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("orders")
      .whereField("status", isEqualTo: "ongoing")
      .addSnapshotListener { [weak self] snapshot, error in
        guard let self = self else { return }
        
        if let error = error {
          print("⚠️ DEBUG: Snapshot listener error: \(error.localizedDescription)")
          return
        }
        guard let documents = snapshot?.documents else {
          print("⚠️ DEBUG: Fetching documents error!")
          return
        }
        let newOngoingOrders = documents.compactMap { document -> Order? in
          // Retrieves all fields in a document and convert them to an instance of caller-specified type.
          try? document.data(as: Order.self)
        }
        // Update ongoing orders array. Should be called on the main thread.
        self.ongoingOrders = newOngoingOrders
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
  
  // MARK: - Received Orders
  
  func getReceivedOrders() {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("orders")
      .whereField("status", isEqualTo: "received")
      .order(by: "timestamp", descending: true)
      .addSnapshotListener { [weak self] snapshot, error in
        guard let self = self else { return }
        
        if let error {
          print("DEBUG ⚠️: Error listening for documents: \(error.localizedDescription)")
          return
        }
        guard let documents = snapshot?.documents else {
          print("⚠️ Failed to get the documents")
          return
        }
        let receivedOrders = documents.compactMap { document -> Order? in
          try? document.data(as: Order.self)
        }
        // // Update ongoing orders array. Should be called on the main thread.
        self.receivedOrders = receivedOrders
      }
  }
}
