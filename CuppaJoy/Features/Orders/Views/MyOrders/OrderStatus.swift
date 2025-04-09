//
//  OrderStatus.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 10.04.2025.
//

import Foundation

enum OrderStatus: String, CaseIterable, Identifiable {
  case ongoing
  case received
  
  var id: String { self.rawValue }
  var title: String { rawValue.capitalized }
  
  var iconName: String {
    switch self {
    case .ongoing: "cart.badge.clock"
    case .received: "cart.fill"
    }
  }
}
