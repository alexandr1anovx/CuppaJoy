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
  
  var hint: String {
    switch self {
    case .fullName: "Full Name"
    case .email: "Email address"
    case .password: "Password"
    }
  }
  
  var iconName: String {
    switch self {
    case .fullName: "person.crop.circle"
    case .email: "envelope"
    case .password: "lock"
    }
  }
}

enum InputContentStatus {
  case secured, notSecured
}
