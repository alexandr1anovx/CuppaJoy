//
//  ValidationService.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.04.2025.
//

import Foundation

final class ValidationService {
  
  static func isValid(fullName: String) -> Bool {
    let regex = ValidationRegex.fullName
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: fullName)
  }
  
  static func isValid(email: String) -> Bool {
    let regex = ValidationRegex.email
    let predicate = NSPredicate(format: "SELF MATCHES[c] %@", regex)
    return predicate.evaluate(with: email)
  }
  
  static func isValid(password: String) -> Bool {
    let regex = ValidationRegex.password
    let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
    return predicate.evaluate(with: password)
  }
}
