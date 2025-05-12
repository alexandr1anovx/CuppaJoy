//
//  OrderServiceProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.04.2025.
//

protocol OrderServiceProtocol {
  func getOngoingOrders()
  func getReceivedOrders()
  func setOngoingOrder(_ order: Order) async throws
  func cancelOngoingOrder(_ order: Order) async throws
}
