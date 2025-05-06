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
  
  init() {
    setupBindings()
  }
  
  // MARK: - Ongoing Orders
  
  func getOngoingOrders() {
    orderService.getOngoingOrders()
  }
  
  func setOngoingOrders(_ order: Order) {
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
    // Using KVO to observe changes in the service's arrays
    orderService.getOngoingOrders()
    orderService.getReceivedOrders()
    //orderService.getConfigs()
    
    // Update our published properties whenever the service's properties change
    Timer.publish(every: 0.5, on: .main, in: .common)
      .autoconnect()
      .sink { [weak self] _ in
        guard let self = self else { return }
        self.ongoingOrders = self.orderService.ongoingOrders
        self.receivedOrders = self.orderService.receivedOrders
        //self.favoriteConfigs = self.orderService.favoriteConfigs
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
