//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation

@MainActor
final class OrderViewModel: ObservableObject {
  
  // MARK: Public Properties
  
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  // MARK: Private Properties
  
  private let orderService: OrderService
  
  // MARK: - Initializer
  
  init(orderService: OrderService = OrderService()) {
    self.orderService = orderService
    setupBindings()
    getOngoingOrders()
    getReceivedOrders()
  }
  
  // MARK: - Public Methods
  
  func getOngoingOrders() {
    orderService.getOngoingOrders()
  }
  
  func getReceivedOrders() {
    orderService.getReceivedOrders()
  }
  
  func setOngoingOrder(_ order: Order) async {
    do {
      try await orderService.setOngoingOrder(order)
    } catch {
      print("‼️ Cannot set ongoing order: \(error)")
    }
  }
  
  func cancelOngoingOrder(_ order: Order) async {
    do {
     try await orderService.cancelOngoingOrder(order)
    } catch {
      print("‼️ Cannot cancel ongoing order: \(error)")
    }
  }
  
  // MARK: - Private Methods
  
  private func setupBindings() {
    orderService.$ongoingOrders
      .receive(on: DispatchQueue.main)
      .assign(to: &$ongoingOrders)
    
    orderService.$receivedOrders
      .receive(on: DispatchQueue.main)
      .assign(to: &$receivedOrders)
  }
}
