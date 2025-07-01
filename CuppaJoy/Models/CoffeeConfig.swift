//
//  CoffeeConfig.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 18.04.2025.
//

import Foundation
import FirebaseFirestore

struct CoffeeConfig: Identifiable, Hashable, Codable {
  @DocumentID var id: String?
  let uid: String
  var title: String
  var cupSize: String
  var sugarSticks: Int
  var iceCubes: Int
  var variety: String
  var milk: String
  var flavor: String
  
  init(
    uid: String,
    title: String,
    cupSize: String,
    sugarSticks: Int,
    iceCubes: Int,
    variety: String,
    milk: String,
    flavor: String
  ) {
    self.uid = uid
    self.title = title
    self.cupSize = cupSize
    self.sugarSticks = sugarSticks
    self.iceCubes = iceCubes
    self.variety = variety
    self.milk = milk
    self.flavor = flavor
  }
}
