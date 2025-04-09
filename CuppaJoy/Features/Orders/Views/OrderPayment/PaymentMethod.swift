//
//  PaymentMethod.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 10.04.2025.
//

import Foundation

enum PaymentMethod {
  case applePay
  case creditCard
  
  var title: String {
    switch self {
    case .applePay: "Apple Pay"
    case .creditCard: "Credit Card"
    }
  }
  var iconName: String {
    switch self {
    case .applePay: "apple.logo"
    case .creditCard: "creditcard.fill"
    }
  }
}
