//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation

@MainActor
final class OrderViewModel: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  // MARK: - Private Properties
  
  private let orderService: OrderService
  
  // MARK: - Init
  
  init(orderService: OrderService = OrderService()) {
    self.orderService = orderService
    fetchOngoingOrders()
    fetchReceivedOrders()
  }
  
  // MARK: - Public Methods
  
  func fetchOngoingOrders() {
    orderService.getOrders(forStatus: .ongoing) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let orders):
          self?.ongoingOrders = orders
        case .failure(let error):
          print("❌ Failed to get ongoing orders: \(error.localizedDescription)")
        }
      }
    }
  }
  
  func fetchReceivedOrders() {
    orderService.getOrders(forStatus: .received) { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case .success(let orders):
          self?.receivedOrders = orders
        case .failure(let error):
          print("❌ Failed to get ongoing orders: \(error.localizedDescription)")
        }
      }
    }
  }
  
  func setOngoingOrder(_ order: Order) async {
    do {
      try await orderService.setOngoingOrder(order)
    } catch {
      print("❌ Failed to set ongoing order: \(error.localizedDescription)")
    }
  }
  
  func cancelOngoingOrder(_ order: Order) async {
    do {
     try await orderService.cancelOngoingOrder(order)
    } catch {
      print("❌ Failed to cancel ongoing order: \(error.localizedDescription)")
    }
  }
}

// MARK:  Preview Mode

extension OrderViewModel {
  static var previewMode: OrderViewModel {
    let viewModel = OrderViewModel()
    viewModel.ongoingOrders = [MockData.order]
    viewModel.receivedOrders = [MockData.order]
    return viewModel
  }
}
