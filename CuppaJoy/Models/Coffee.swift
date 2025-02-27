//
//  Coffee.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation

struct Coffee {
  let id: String // Firestore document ID
  let title: String
  let description: String
  let rating: Double
  let price: Double
  
  var formattedRating: String {
    "\(String(format: "%.1f", rating))"
  }
  
  var formattedPrice: String {
    "$\(String(format: "%.1f", price))"
  }
}
