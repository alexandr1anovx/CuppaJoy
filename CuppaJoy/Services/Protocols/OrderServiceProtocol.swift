//
//  OrderServiceProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

import Foundation

protocol OrderServiceProtocol {
  var ongoingOrders: [Order] { get set }
  var receivedOrders: [Order] { get set }
  func getOngoingOrders()
  func getReceivedOrders()
  func setOngoingOrders(_ order: Order)
  func setReceivedOrders(_ order: Order)
  func cancelOngoingOrder(_ order: Order)
}
