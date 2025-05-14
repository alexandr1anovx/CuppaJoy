//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import FirebaseAuth
import FirebaseFirestore

final class OrderService: OrderServiceProtocol {
  
  // MARK: - Private Properties
  
  private let database = Firestore.firestore()
  private var ordersListener: ListenerRegistration?
  
  // MARK: - Deinit
  
  deinit { ordersListener?.remove() }
  
  // MARK: - Public Methods
  
  func getOrders(
    forStatus status: OrderStatus,
    completion: @escaping (Result<[Order], any Error>) -> Void
  ) {
    ordersListener?.remove()
    
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    ordersListener = database
      .collection("users")
      .document(uid)
      .collection("orders")
      .whereField("status", isEqualTo: status.rawValue)
      .addSnapshotListener { snapshot, error in
        if let error {
          print("❌ Failed to get orders: \(error)")
          completion(.failure(error))
        }
        guard let documents = snapshot?.documents else {
          print("❌ Failed to read coffee documents!")
          completion(.failure(
            NSError(domain: "Firestore", code: -1, userInfo: [NSLocalizedDescriptionKey: "No documents found."]))
          )
          return
        }
        let orders = documents.compactMap {
          try? $0.data(as: Order.self)
        }
        completion(.success(orders))
        print("✅ ORDERS: \(orders)")
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
