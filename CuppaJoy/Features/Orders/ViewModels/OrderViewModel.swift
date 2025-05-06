//
//  OrderViewModel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import Foundation
import Combine

@MainActor
final class OrderViewModel: ObservableObject {
  
  @Published var ongoingOrders: [Order] = []
  @Published var receivedOrders: [Order] = []
  
  private let orderService = OrderService.shared
  private var cancellables = Set<AnyCancellable>()
  
  init() { setupBindings() }
  
  // MARK: - Ongoing Orders
  
  func getOngoingOrders() {
    orderService.getOngoingOrders()
  }
  
  func setOngoingOrder(_ order: Order) {
    orderService.setOngoingOrder(order)
  }
  
  func cancelOngoingOrder(_ order: Order) {
    orderService.cancelOngoingOrder(order)
  }
  
  // MARK: - Received Orders
  
  func getReceivedOrders() {
    orderService.getReceivedOrders()
  }
  
  // MARK: Private Methods
  
  private func setupBindings() {
    orderService.getOngoingOrders()
    orderService.getReceivedOrders()
    
    Timer.publish(every: 0.5, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.ongoingOrders = self.orderService.ongoingOrders
        self.receivedOrders = self.orderService.receivedOrders
      }
      .store(in: &cancellables)
  }
}

// MARK: - Preview Mode

extension OrderViewModel {
  static func previewMode() -> OrderViewModel {
    let viewModel = OrderViewModel()
    //viewModel.favoriteConfigs = [MockData.config2]
    return viewModel
  }
}
