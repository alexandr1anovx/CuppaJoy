//
//  OnboardingPage.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.01.2025.
//

import SwiftUI

enum OnboardingPage: Int, CaseIterable {
  case greeting
  case delivery
  case payment
  case welcome
  
  var title: String {
    switch self {
    case .greeting: "Welcome to Cuppa Joy"
    case .delivery: "Coffee Delivered to Your Doorstep"
    case .payment: "Seamless Payments with Apple Pay"
    case .welcome: "Discover Your Coffee Journey"
    }
  }
  
  var description: String {
    switch self {
    case .greeting:
      "Start your day with the perfect cup of coffee, crafted just the way you like it."
    case .delivery:
      "Get your favorite brews delivered fast and fresh, wherever you are."
    case .payment:
      "Enjoy quick and secure payments with just a tap."
    case .welcome:
      "Join us and explore a world of rich aromas."
    }
  }
  
  var image: String {
    switch self {
    case .greeting: "onboardingLogo"
    case .delivery: "onboardingDelivery"
    case .payment: "onboardingPayment"
    case .welcome: "onboardingCup"
    }
  }
}
