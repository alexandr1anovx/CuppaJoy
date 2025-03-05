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
  
  // MARK: Cancel Ongoing Order
  func cancelOngoingOrder(_ order: Order) {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data.")
      return
    }
    
    ongoingOrders.removeAll { $0.id == order.id }
    
    userCollection.document(userID).collection("ongoingOrders").document(order.id)
      .delete { error in
        guard let error = error else {
          print("Order successfully deleted from Firestore!")
          return
        }
        print("Error deleting order: \(error.localizedDescription)")
      }
  }
  
  // MARK: Set Ongoing Orders
  
  func setOngoingOrders(_ order: Order) {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data.")
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
      "totalPrice": order.totalPrice
    ]
    userCollection.document(userID).collection("ongoingOrders").document(order.id)
      .setData(orderData) { error in
        if let error = error {
          print("Error writing document: \(error)")
        } else {
          print("Order document successfully written!")
        }
      }
  }
  
  // MARK: Set Received Orders
  
  func setReceivedOrders(_ order: Order) {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data.")
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
      "totalPrice": order.totalPrice
    ]
    userCollection.document(userID).collection("receivedOrders").document(order.id)
      .setData(orderData) { error in
        if let error = error {
          print("Error writing document: \(error)")
        } else {
          print("Order document successfully written!")
        }
      }
  }
  
  // MARK: Get Ongoing Orders
  
  func getOngoingOrders() {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data.")
      return
    }
    userCollection.document(userID).collection("ongoingOrders")
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error listening for documents: \(error)")
          return
        }
        guard let documents = querySnapshot?.documents else {
          print("Error fetching documents: \(error!)")
          return
        }
        self.ongoingOrders = documents.compactMap { doc -> Order? in
          try? doc.data(as: Order.self)
        }
      }
  }
  
  // MARK: Get Received Orders
  
  func getReceivedOrders() {
    guard let userID = Auth.auth().currentUser?.uid else {
      print("Cannot get the user data.")
      return
    }
    userCollection.document(userID).collection("receivedOrders")
      .order(by: "timestamp", descending: true)
      .addSnapshotListener { querySnapshot, error in
        if let error = error {
          print("Error listening for documents: \(error)")
          return
        }
        guard let documents = querySnapshot?.documents else {
          print("Error fetching documents: \(error!)")
          return
        }
        self.receivedOrders = documents.compactMap { doc -> Order? in
          try? doc.data(as: Order.self)
        }
      }
  }
}
