//
//  Tab.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import Foundation

enum TabItem: Int, CaseIterable {
  case home = 0, rewards, orders
  
  var title: String {
    switch self {
    case .home: ""
    case .rewards: ""
    case .orders: ""
    }
  }
  
  var iconName: String {
    switch self {
    case .home: "house"
    case .rewards: "gift"
    case .orders: "bill"
    }
  }
}
