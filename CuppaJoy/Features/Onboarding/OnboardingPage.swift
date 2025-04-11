//
//  OnboardingPage.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.01.2025.
//

import Foundation

enum OnboardingPage: Int, CaseIterable {
  case greeting
  case delivery
  case payment
  case welcome
  
  var title: String {
    switch self {
    case .greeting: "Discover your coffee journey"
    case .delivery: "Fast Delivery"
    case .payment: "Easy Payment"
    case .welcome: "Welcome to Cuppa Joy!"
    }
  }
  
  var description: String {
    switch self {
    case .greeting: "Start your day with the perfect cup of coffee."
    case .delivery: "Get your favorite brews delivered fast and fresh."
    case .payment: "Enjoy quick and secure payments with Apple Pay."
    case .welcome: "Join us and explore a world of rich aromas."
    }
  }
  
  var image: String {
    switch self {
    case .greeting: "onboardingCup"
    case .delivery: "onboardingDelivery"
    case .payment: "onboardingPayment"
    case .welcome: "onboardingLogo"
    }
  }
}
