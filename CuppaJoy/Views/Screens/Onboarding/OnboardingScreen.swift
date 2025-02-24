//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingScreen: View {
  
  // MARK: Properties
  @State private var pageIndex = 0
  @State private var isFinishedOnboarding = false
  let pages = OnboardingPage.allCases
  
  var isIndexLast: Bool {
    pageIndex == pages.count - 1
  }
  
  // MARK: body
  var body: some View {
    if isFinishedOnboarding {
      SignInScreen()
    } else {
      onboardingPage
    }
  }
  
  // MARK: Onboarding Page
  private var onboardingPage: some View {
    ZStack(alignment: .bottom) {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(spacing: 35) {
        Spacer()
        onboardingData(for: pages[pageIndex])
        pageIndicator
        Spacer()
      }
      continueButton.padding(.bottom, 10)
    }
  }
  
  // MARK: Page Data
  private func onboardingData(for page: OnboardingPage) -> some View {
    VStack(spacing: 12) {
      Image(page.image)
        .resizable()
        .frame(width: 150, height: 150)
        .foregroundStyle(.csCream)
        .padding(.bottom)
      Text(page.title)
        .font(.title3)
        .fontWeight(.bold)
        .foregroundStyle(.white)
      Text(page.description)
        .font(.footnote)
        .fontWeight(.semibold)
        .foregroundStyle(.gray)
        .multilineTextAlignment(.center)
        .lineLimit(2)
    }
    .padding(.horizontal, 20)
    .animation(.spring, value: pageIndex)
  }
  
  // MARK: Page Indicator
  private var pageIndicator: some View {
    HStack(spacing: 15) {
      ForEach(0..<pages.count, id: \.self) { index in
        Capsule()
          .frame(width: 20, height: 2.5)
          .foregroundStyle(
            pageIndex >= index ? .csCream : .csDarkGrey
          )
          .animation(.spring, value: pageIndex)
      }
    }
  }
  
  // MARK: "Continue" button
  private var continueButton: some View {
    Button {
      if !isIndexLast {
        pageIndex += 1
      } else {
        withAnimation { isFinishedOnboarding = true }
      }
    } label: {
      ButtonLabel(
        isIndexLast ? "Get Started!": "Continue",
        textColor: .white,
        pouring: .black
      )
    }
  }
}

#Preview {
  OnboardingScreen()
}
