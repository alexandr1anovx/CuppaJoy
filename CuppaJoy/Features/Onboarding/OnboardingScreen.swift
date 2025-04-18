//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingScreen: View {
  
  @State private var pageIndex = 0
  @State private var isFinishedOnboarding = false
  @State private var isAnimating = false
  
  private let pages = OnboardingPage.allCases
  private var isIndexLast: Bool { pageIndex == pages.count - 1 }
  
  var body: some View {
    if isFinishedOnboarding {
      SignInScreen()
    } else {
      onboardingPage
    }
  }
  
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
  
  private func onboardingData(for page: OnboardingPage) -> some View {
    VStack(spacing: 12) {
      Image(page.image)
        .resizable()
        .frame(width: 130, height: 130)
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
  
  private var continueButton: some View {
    Button {
      if !isIndexLast {
        pageIndex += 1
      } else {
        UserDefaults.standard.isFirstLaunch = false
        withAnimation { isFinishedOnboarding = true }
      }
    } label: {
      ButtonLabelWithIconAnimated(
        isIndexLast ? "Get Started!": "Continue",
        icon: isIndexLast ? "checkmark.seal.fill": "arrow.right.circle.fill",
        textColor: isIndexLast ? .black : .white,
        bgColor: isIndexLast ? Color.gradientCream : Color.gradientBrownBlack
      )
    }
  }
}

#Preview {
  OnboardingScreen()
}
