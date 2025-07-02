//
//  User.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation
import FirebaseFirestore

struct User: Identifiable, Codable {
  @DocumentID var id: String?
  let uid: String
  var fullName: String
  var email: String
  var city: String
  var coins: Int
  
  init(
    uid: String,
    fullName: String,
    email: String,
    city: String,
    coins: Int
  ) {
    self.id = uid
    self.uid = uid
    self.fullName = fullName
    self.email = email
    self.city = city
    self.coins = coins
  }
  
  var stringCoins: String {
    "\(coins)"
  }
}
