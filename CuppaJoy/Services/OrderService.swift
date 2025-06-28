//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import FirebaseAuth
import FirebaseFirestore

enum OrderServiceError: Error {
  case userNotLoggedIn
  case missingOrderID
}

protocol OrderServiceProtocol {
  func fetchAllOrders() -> AsyncStream<Result<[Order], Error>>
  func makeOrder(_ order: Order) async throws
  func cancelOrder(_ order: Order) async throws
}

final class OrderService: OrderServiceProtocol {
  
  private let db = Firestore.firestore()
  
  private func ordersCollection(forUserID uid: String) -> CollectionReference {
    return db
      .collection("users")
      .document(uid)
      .collection("orders")
  }
  
  func fetchAllOrders() -> AsyncStream<Result<[Order], Error>> {
    AsyncStream { continuation in
      guard let uid = Auth.auth().currentUser?.uid else {
        continuation.yield(.failure(OrderServiceError.userNotLoggedIn))
        continuation.finish()
        return
      }
      let listener = ordersCollection(forUserID: uid)
        .addSnapshotListener { snapshot, error in
          if let error {
            continuation.yield(.failure(error))
            return
          }
          guard let documents = snapshot?.documents else {
            continuation.yield(.success([]))
            return
          }
          let orders = documents.compactMap {
            try? $0.data(as: Order.self)
          }
          continuation.yield(.success(orders))
        }
      continuation.onTermination = { @Sendable _ in
        listener.remove()
        print("✅ Orders listener removed.")
      }
    }
  }
  
  func makeOrder(_ order: Order) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw AuthErrorCode.nullUser
    }
    guard let orderId = order.id else {
      throw OrderServiceError.missingOrderID
    }
    try ordersCollection(forUserID: uid)
      .document(orderId)
      .setData(from: order)
  }
  
  func cancelOrder(_ order: Order) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw AuthErrorCode.nullUser
    }
    guard let orderId = order.id else {
      throw OrderServiceError.missingOrderID
    }
    try await ordersCollection(forUserID: uid)
      .document(orderId)
      .delete()
  }
}
