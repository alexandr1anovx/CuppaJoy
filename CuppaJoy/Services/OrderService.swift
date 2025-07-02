//
//  OrderService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import FirebaseAuth
import FirebaseFirestore

// MARK: - Order Service Protocol

protocol OrderServiceProtocol {
  func fetchAllOrders() -> AsyncStream<Result<[Order], Error>>
  func makeOrder(_ order: Order) async throws
  func cancelOrder(_ order: Order) async throws
}

final class OrderService: OrderServiceProtocol {
  
  private let db = Firestore.firestore()
  private let usersCollection: String = "users"
  private let ordersCollection: String = "orders"
  
  init() { print("OrderService INITIALIZED") }
  deinit { print("OrderService DEINITIALIZED") }
  
  // MARK: - Public Methods
  
  func fetchAllOrders() -> AsyncStream<Result<[Order], Error>> {
    AsyncStream { continuation in
      guard let uid = Auth.auth().currentUser?.uid else {
        continuation.yield(.failure(AuthErrorCode.userNotFound))
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
      }
    }
  }
  
  func makeOrder(_ order: Order) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw AuthErrorCode.nullUser
    }
    try ordersCollection(forUserID: uid)
      .document(order.uid)
      .setData(from: order)
  }
  
  func cancelOrder(_ order: Order) async throws {
    guard let uid = Auth.auth().currentUser?.uid else {
      throw AuthErrorCode.nullUser
    }
    try await ordersCollection(forUserID: uid)
      .document(order.uid)
      .delete()
  }
  
  // MARK: - Private Methods
  
  private func ordersCollection(forUserID uid: String) -> CollectionReference {
    return db
      .collection(usersCollection)
      .document(uid)
      .collection(ordersCollection)
  }
}
