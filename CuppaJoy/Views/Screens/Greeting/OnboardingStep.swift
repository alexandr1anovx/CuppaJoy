//
//  OnboardingStep.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingStep {
  let image: ImageResource
  let title: String
  let description: String
}

struct MockData {
  static let onboardingSteps: [OnboardingStep] = [
    OnboardingStep(
      image: .applePay,
      title: "First Onboarding Screen",
      description: "First Onboarding Screen Description"
    ),
    OnboardingStep(
      image: .beans,
      title: "Second Onboarding Screen",
      description: "Second Onboarding Screen Description"
    ),
    OnboardingStep(
      image: .coffeeGlass,
      title: "Third Onboarding Screen",
      description: "Third Onboarding Screen Description"
    )
  ]
}
