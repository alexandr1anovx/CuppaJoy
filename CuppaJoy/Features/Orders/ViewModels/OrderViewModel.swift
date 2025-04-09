//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@MainActor
final class OrderViewModel: ObservableObject {
  
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  let userCollection = Firestore.firestore().collection("users")
  
  // MARK: - Ongoing Orders
  
  func getOngoingOrders() {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data when calling 'getOngoingOrders' method.")
      return
    }
    userCollection.document(userID).collection("orders")
      .whereField("status", isEqualTo: "ongoing")
      .addSnapshotListener { querySnapshot, error in
        if let error {
          print("Error listening for documents: \(error)")
          return
        }
        guard let documents = querySnapshot?.documents else {
          print("Error fetching documents: \(error!)")
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
  
  func setOngoingOrders(_ order: Order) {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data when calling 'setOngoingOrders' method.")
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
    userCollection.document(userID).collection("orders").document(order.id)
      .setData(orderData) { error in
        if let error {
          print("Error writing document: \(error)")
        } else {
          print("Order document successfully written.")
        }
      }
  }
  
  func cancelOngoingOrder(_ order: Order) {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data when calling 'cancelOngoingOrder' method.")
      return
    }
    ongoingOrders.removeAll { $0.id == order.id }
    userCollection.document(userID).collection("orders").document(order.id)
      .delete { error in
        guard let error else {
          print("Order successfully deleted from Firestore.")
          return
        }
        print("Error deleting order: \(error.localizedDescription)")
      }
  }
  
  // MARK: - Received Orders
  
  func getReceivedOrders() {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data.")
      return
    }
    userCollection.document(userID).collection("orders")
      .whereField("status", isEqualTo: "received")
      .order(by: "timestamp", descending: true)
      .addSnapshotListener { querySnapshot, error in
        if let error {
          print("Error listening for documents: \(error)")
          return
        }
        guard let documents = querySnapshot?.documents else {
          print("Error fetching documents: \(error!)")
          return
        }
        let newReceivedOrders = documents.compactMap { doc -> Order? in
          try? doc.data(as: Order.self)
        }
        self.receivedOrders = newReceivedOrders
        self.ongoingOrders.removeAll { order in
          newReceivedOrders.contains(where: { $0.id == order.id })
        }
      }
  }
  
  func setReceivedOrders(_ order: Order) {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data when calling 'setReceivedOrders' method.")
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
      "status": "received"
    ]
    userCollection.document(userID).collection("orders").document(order.id)
      .setData(orderData) { error in
        if let error {
          print("Error writing document: \(error)")
        } else {
          print("Order document successfully written!")
        }
      }
  }
}

