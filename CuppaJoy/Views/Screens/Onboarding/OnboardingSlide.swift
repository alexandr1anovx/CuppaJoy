//
//  OnboardingStep.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingPage {
  let image: String
  let title: String
  let description: String
  let color: Color
}

struct MockData {
  static let slides: [OnboardingPage] = [
    OnboardingPage(
      image: "breakfast",
      title: "Find Your Flavor",
      description: "Explore coffee blends crafted for every taste.",
      color: .accent
    ),
    OnboardingPage(
      image: "eating",
      title: "Coffee’s Perfect Match",
      description: "Add a tasty snack to your coffee order.",
      color: .accent
    ),
    OnboardingPage(
      image: "caffeine",
      title: "Coffee, Just a Tap Away",
      description: "Order your coffee fast and pick it up easily.",
      color: .accent
    ),
    OnboardingPage(
      image: "breakfast2",
      title: "Your Coffee Journey Begins",
      description: "You’re ready! Welcome to the Cuppa Joy family.",
      color: .orange
    )
  ]
}
