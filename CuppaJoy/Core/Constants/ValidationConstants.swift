//
//  ValidationConstants.swift
//  CuppaJoy
//
//  Created by Oleksandr Andrianov on 18.12.2025.
//

import Foundation

enum ValidationRegex {
  static let fullName = #"^[a-zA-Z-]+ ?.* [a-zA-Z-]+$"#
  static let email = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
  static let password = #"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"#
}
