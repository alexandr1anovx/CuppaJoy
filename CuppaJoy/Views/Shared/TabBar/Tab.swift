//
//  Tab.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import Foundation

enum Tab: Int, CaseIterable {
    case home = 0, rewards, orders
    
    var title: String {
        switch self {
        case .home: "Home"
        case .rewards: "Rewards"
        case .orders: "Orders"
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
