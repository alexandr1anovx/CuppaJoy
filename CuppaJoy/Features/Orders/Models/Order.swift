//
//  Order.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation

struct Order: Identifiable, Codable, Hashable {
  let id: String
  let coffee: String
  let cupSize: String
  let cupCount: Int
  let sugarSticks: Int
  let iceCubes: Int
  let variety: String
  let milk: String
  let flavor: String
  let timestamp: Date
  let points: Int
  let totalPrice: Double
  
  var stringPoints: String {
    "\(points)"
  }
  var stringDate: String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy, HH:mm"
    return formatter.string(from: timestamp)
  }
  var stringPrice: String {
    "$\(String(format: "%.2f", totalPrice))"
  }
  
}
