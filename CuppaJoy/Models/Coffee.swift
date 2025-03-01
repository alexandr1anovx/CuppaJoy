//
//  Coffee.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation

struct Coffee {
  let id: String
  let title: String
  let description: String
  let rating: Double
  let points: Int
  let price: Double
  
  var stringPoints: String {
    "\(points)"
  }
  var stringRating: String {
    "\(String(format: "%.1f", rating))"
  }
  var stringPrice: String {
    "$\(String(format: "%.2f", price))"
  }
}
