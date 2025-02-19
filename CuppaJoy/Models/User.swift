//
//  User.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import Foundation

struct User: Identifiable, Codable {
  
  let id: String
  let firstName: String
  let lastName: String
  let emailAddress: String
  let phoneNumber: String
  
  var initians: String {
    "\(firstName) \(lastName)"
  }
}
