//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import FirebaseAuth
import FirebaseFirestore

final class OrderService: OrderServiceProtocol, ObservableObject {
  
  // MARK: Public Properties
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  // MARK: Private Properties
  private let database = Firestore.firestore()
  private var ongoingOrdersListener: ListenerRegistration?
  private var receivedOrdersListener: ListenerRegistration?
  
  // MARK: - Deinitialization
  deinit {
    ongoingOrdersListener?.remove()
    receivedOrdersListener?.remove()
  }
  
  // MARK: - Public Methods
  
  func getOngoingOrders() {
    // Remove previous listeners.
    ongoingOrdersListener?.remove()
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    ongoingOrdersListener = database
      .collection("users")
      .document(uid)
      .collection("orders")
      .whereField("status", isEqualTo: "ongoing")
      .addSnapshotListener { [weak self] snapshot, error in
        if let error = error {
          print("⚠️ Failed to get ongoing orders: \(error)")
        }
        guard let self = self else { return }
        guard let documents = snapshot?.documents else { return }
        let orders = documents.compactMap {
          try? $0.data(as: Order.self)
        }
        DispatchQueue.main.async {
          self.ongoingOrders = orders
        }
      }
  }
  
  func getReceivedOrders() {
    // Remove previous listeners.
    receivedOrdersListener?.remove()
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    database
      .collection("users")
      .document(uid)
      .collection("orders")
      .whereField("status", isEqualTo: "received")
      .addSnapshotListener { [weak self] snapshot, error in
        if let error = error {
          print("⚠️ Failed to get received orders: \(error)")
        }
        guard let self = self else { return }
        guard let documents = snapshot?.documents else { return }
        let orders = documents.compactMap {
          try? $0.data(as: Order.self)
        }
        DispatchQueue.main.async {
          self.receivedOrders = orders
        }
      }
  }
  
  func setOngoingOrder(_ order: Order) async throws {
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
    try await database
      .collection("users")
      .document(uid)
      .collection("orders")
      .document(order.id)
      .setData(orderData)
  }
  
  func cancelOngoingOrder(_ order: Order) async throws {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    try await database
      .collection("users")
      .document(uid)
      .collection("orders")
      .document(order.id)
      .delete()
  }
}
