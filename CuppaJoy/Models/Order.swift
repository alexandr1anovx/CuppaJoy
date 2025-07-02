//
//  Order.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation
import FirebaseFirestore

struct Order: Identifiable, Codable, Hashable {
  
  @DocumentID var id: String?
  let uid: String
  var coffee: String
  var cupSize: String
  var cupCount: Int
  var sugarSticks: Int
  var iceCubes: Int
  var variety: String
  var milk: String
  var flavor: String
  var points: Int
  var totalPrice: Double
  var timestamp: Date
  var status: String
  
  init(
    uid: String,
    coffee: String,
    cupSize: String,
    cupCount: Int,
    sugarSticks: Int,
    iceCubes: Int,
    variety: String,
    milk: String,
    flavor: String,
    points: Int,
    totalPrice: Double,
    timestamp: Date,
    status: String
  ) {
    self.uid = uid
    self.coffee = coffee
    self.cupSize = cupSize
    self.cupCount = cupCount
    self.sugarSticks = sugarSticks
    self.iceCubes = iceCubes
    self.variety = variety
    self.milk = milk
    self.flavor = flavor
    self.points = points
    self.totalPrice = totalPrice
    self.timestamp = timestamp
    self.status = status
  }
  
  var formattedDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy, HH:mm"
    return formatter.string(from: timestamp)
  }
  
  var formattedPrice: String {
    "$\(String(format: "%.2f", totalPrice))"
  }
}
