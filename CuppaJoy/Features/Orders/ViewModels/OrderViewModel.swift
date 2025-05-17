//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation
import FirebaseAuth

@MainActor
final class OrderViewModel: ObservableObject {
  
  // MARK: - Public Properties
  
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  // MARK: - Private Properties
  
  private let orderService: OrderService
  private var observer: NSObjectProtocol?
  
  // MARK: - Init / Deinit
  
  init(orderService: OrderService = OrderService()) {
    self.orderService = orderService
    setupAuthObserver()
  }
  
  deinit {
    if let observer = observer {
      NotificationCenter.default.removeObserver(observer)
    }
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
  
  // MARK:  - Private Methods
  
  private func setupAuthObserver() {
    self.observer = NotificationCenter.default.addObserver(
      forName: .authUserDidChange,
      object: nil,
      queue: .main,
      using: { [weak self] notification in
        Task { @MainActor in
          if let _ = notification.object as? FirebaseAuth.User {
            self?.fetchOngoingOrders()
            self?.fetchReceivedOrders()
          } else {
            self?.ongoingOrders = []
            self?.receivedOrders = []
          }
        }
      }
    )
  }
}

// MARK:  - Preview Mode

extension OrderViewModel {
  static var previewMode: OrderViewModel {
    let viewModel = OrderViewModel()
    viewModel.ongoingOrders = [MockData.order]
    viewModel.receivedOrders = [MockData.order]
    return viewModel
  }
}
