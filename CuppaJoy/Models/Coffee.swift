//
//  Coffee.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 26.02.2025.
//

import Foundation
import FirebaseFirestore

struct Coffee: Hashable, Decodable {
  @DocumentID var id: String?
  let uid: String
  let title: String
  let description: String
  let rating: Double
  let points: Int
  let price: Double
  
  init(
    uid: String,
    title: String,
    description: String,
    rating: Double,
    points: Int,
    price: Double
  ) {
    self.uid = uid
    self.title = title
    self.description = description
    self.rating = rating
    self.points = points
    self.price = price
  }
  
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
