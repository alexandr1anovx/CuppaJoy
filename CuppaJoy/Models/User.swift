//
//  User.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation

struct User: Identifiable, Codable {
  let id: String
  let fullName: String
  let emailAddress: String
  let city: String
  var coins: Int
  
  var stringCoins: String {
    "\(coins)"
  }
}
