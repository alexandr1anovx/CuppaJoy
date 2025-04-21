//
//  City.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.04.2025.
//

import Foundation

enum City: String, Identifiable, CaseIterable {
  case mykolaiv, odesa
  
  var id: Self { self }
  var title: String { rawValue.capitalized }
}
