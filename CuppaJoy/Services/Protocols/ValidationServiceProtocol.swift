//
//  ValidationServiceProtocol.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.04.2025.
//

import Foundation

protocol ValidationServiceProtocol {
  func isValid(fullName: String) -> Bool
  // func isValid(phoneNumber: String) -> Bool
  func isValid(email: String) -> Bool
  func isValid(password: String) -> Bool
}
