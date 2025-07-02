//
//  TextFieldContentType.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 31.03.2025.
//

import Foundation

enum InputContentType {
  case fullName
  case email
  case password
  case confirmPassword
  
  var hint: String {
    switch self {
    case .fullName: "Full Name"
    case .email: "Email address"
    case .password: "Password"
    case .confirmPassword: "Confirm password"
    }
  }
  
  var iconName: String {
    switch self {
    case .fullName: "person.crop.circle"
    case .email: "envelope"
    case .password: "lock"
    case .confirmPassword: "lock"
    }
  }
}

enum InputContentStatus {
  case secured, notSecured
}
