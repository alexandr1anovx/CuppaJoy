//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingScreen: View {
  
  @State private var pageIndex: Int = 0
  @State private var isFinishedOnboarding: Bool = false
  @State private var isAnimating: Bool = false
  
  private let pages = OnboardingPage.allCases
  private var isIndexLast: Bool { pageIndex == pages.count - 1 }
  
  var body: some View {
    if isFinishedOnboarding {
      //
    } else {
      onboardingPage
    }
  }
  
  private var onboardingPage: some View {
    ZStack {
      mainGradientBackground
      VStack(spacing: 30) {
        onboardingData(for: pages[pageIndex])
        pageIndicator
      }
    }
    .overlay(alignment: .bottom) {
      continueButton.padding(.bottom,8)
    }
  }
  
  private var mainGradientBackground: some View {
    AngularGradient(
      colors: [.csBrown, .csBrown, .black],
      center: .center,
      angle: .degrees(isAnimating ? 360:0)
    )
    .blur(radius: 50)
    .ignoresSafeArea()
    .onAppear {
      withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
        isAnimating = true
      }
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
      ButtonLabelWithIcon(
        isIndexLast ? "Get Started!": "Continue",
        icon: isIndexLast ? "checkmark.circle.fill": "arrow.right.circle",
        textColor: isIndexLast ? .black : .csCream,
        bgColor: isIndexLast ? .csCream : .csDarkGrey
      )
    }
  }
}

#Preview {
  OnboardingScreen()
}
