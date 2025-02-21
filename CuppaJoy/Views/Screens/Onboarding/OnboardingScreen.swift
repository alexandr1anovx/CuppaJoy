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
  
  let pages = OnboardingPage.allCases
  var isIndexLast: Bool { pageIndex == pages.count - 1 }
  
  // MARK: body
  var body: some View {
    if isFinishedOnboarding {
      SignInScreen()
    } else {
      page
    }
  }
  
  // MARK: Page
  private var page: some View {
    ZStack(alignment: .bottom) {
      Color.appBackground.ignoresSafeArea(.all)
      VStack(spacing: 50) {
        Spacer()
        pageData(for: pages[pageIndex])
        pageIndicator
        Spacer()
      }
      continueButton.padding(.bottom)
    }
  }
  
  // MARK: Page Data
  private func pageData(for page: OnboardingPage) -> some View {
    VStack(spacing: 20) {
      
      VStack(spacing: 15) {
        Image(page.image)
          .resizable()
          .frame(width: 150, height: 150)
          .foregroundStyle(.csDesert)
        Text(page.title)
          .font(.title2).bold()
          .foregroundStyle(.white)
        Text(page.description)
          .font(.footnote)
          .fontWeight(.medium)
          .foregroundStyle(.gray)
          .lineLimit(2)
      }
      .multilineTextAlignment(.center)
      .padding(.horizontal, 30)
    }
    .animation(.easeInOut, value: pageIndex)
  }
  
  // MARK: Page Indicator
  private var pageIndicator: some View {
    HStack(spacing: 15) {
      ForEach(0..<pages.count, id: \.self) { index in
        Capsule()
          .frame(width: 20, height: 3)
          .foregroundStyle(pageIndex >= index ? .accent : .csDarkGrey)
          .animation(.spring, value: pageIndex)
      }
    }
  }
  
  // MARK: Continue Button
  private var continueButton: some View {
    CSButton(isIndexLast ? "Get Started!" : "Continue",
             bgColor: isIndexLast ? .csDesert : .black) {
      if pageIndex < pages.count - 1 {
        pageIndex += 1
      } else {
        withAnimation { isFinishedOnboarding = true }
      }
    }
  }
}

#Preview {
  OnboardingScreen()
}
