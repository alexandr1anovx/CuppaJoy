//
//  TextFieldContentType.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 31.03.2025.
//


enum TextFieldInputType {
  case fullName
  case emailAddress
  case password
  
  var hint: String {
    switch self {
    case .fullName: "Name and surname"
    case .emailAddress: "Email address"
    case .password: "Password"
    }
  }
  
  var icon: String {
    switch self {
    case .fullName: "person.crop.circle"
    case .emailAddress: "envelope"
    case .password: "lock"
    }
  }
}
