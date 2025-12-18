//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Combine
import FirebaseAuth
import SwiftUI

@Observable
final class OrderViewModel {
  
  var ongoingOrders: [Order] = []
  var receivedOrders: [Order] = []
  var isLoading = false
  var alertItem: AlertItem?
  
  var sessionManager: SessionManager
  
  // MARK: - Private Properties
  
  private let orderService: OrderServiceProtocol
  private var cancellables = Set<AnyCancellable>()
  private var ordersSubscriptionTask: Task<Void, Never>?
  
  // MARK: - Init / Deinit
  
  init(
    orderService: OrderServiceProtocol = OrderService(),
    sessionManager: SessionManager
  ) {
    self.orderService = orderService
    self.sessionManager = sessionManager
    setupSessionObserver()
  }
  
  deinit {
    ordersSubscriptionTask?.cancel()
  }
  
  // MARK: - Public Methods
  
  func makeOrder(_ order: Order) async {
    do {
      try await orderService.makeOrder(order)
    } catch {
      print("Failed to make an order: \(error.localizedDescription)")
    }
  }
  
  func cancelOrder(_ order: Order) async {
    do {
      try await orderService.cancelOrder(order)
    } catch {
      print("Failed to cancel order: \(error.localizedDescription)")
    }
  }
  
  // MARK: - Private Subscription Logic
  
  private func setupSessionObserver() {
    sessionManager.$currentUser
      .receive(on: DispatchQueue.main)
      .sink { [weak self] user in
        if user != nil {
          self?.subscribeToAllOrders()
        } else {
          self?.cancelSubscriptionAndClearData()
        }
      }
      .store(in: &cancellables)
  }
  
  private func subscribeToAllOrders() {
    ordersSubscriptionTask?.cancel()
    isLoading = true
    
    ordersSubscriptionTask = Task {
      let stream = orderService.fetchAllOrders()
      
      for await result in stream {
        if Task.isCancelled { break }
        
        self.isLoading = false
        switch result {
        case .success(let allOrders):
          self.ongoingOrders = allOrders
            .filter { $0.status == "ongoing" }
            .sorted(by: { $0.timestamp > $1.timestamp })
          
          self.receivedOrders = allOrders
            .filter { $0.status == "received" }
            .sorted(by: { $0.timestamp > $1.timestamp })
          
        case .failure(let error):
          print("Method 'subscribleToAllOrder' failed: \(error.localizedDescription)")
        }
      }
    }
  }
  
  private func cancelSubscriptionAndClearData() {
    ordersSubscriptionTask?.cancel()
    ongoingOrders = []
    receivedOrders = []
    isLoading = false
  }
}
