//
//  City.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.04.2025.
//

import Foundation

enum City: String, Identifiable, CaseIterable {
  case mykolaiv = "Mykolaiv"
  case odesa = "Odesa"
  
  var id: Self { self }
}
