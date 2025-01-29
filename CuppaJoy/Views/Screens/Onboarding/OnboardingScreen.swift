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
  
  // MARK: - body
  var body: some View {
    if isFinishedOnboarding {
      SignInScreen()
    } else {
      onboardingPage
    }
  }
  
  // MARK: - Onboarding Page
  private var onboardingPage: some View {
    ZStack(alignment: .bottom) {
      Color.appBackground.ignoresSafeArea(.all)
      
      VStack(spacing:30) {
        Spacer()
        pageData(for: pages[pageIndex])
        pageIndicator
        Spacer()
      }
      nextPageButton.padding(.bottom)
    }
  }
  
  // MARK: - Page Data
  private func pageData(for page: OnboardingPage) -> some View {
    VStack(spacing: 20) {
      Image(page.image)
        .resizable()
        .scaledToFit()
        .frame(width: 120, height: 120)
        .foregroundStyle(.csDesert)
      VStack(spacing: 10) {
        Text(page.title)
          .font(.poppins(.bold, size: 18))
          .foregroundStyle(.csDesert)
        Text(page.description)
          .font(.poppins(.medium, size: 13))
          .foregroundStyle(.gray)
          .lineLimit(2)
      }
      .multilineTextAlignment(.center)
    }
    .padding(.horizontal,30)
    .animation(.easeInOut, value: pageIndex)
  }
  
  // MARK: - Page Indicator
  private var pageIndicator: some View {
    HStack(spacing: 15) {
      ForEach(0..<pages.count, id: \.self) { index in
        Capsule()
          .frame(width: 20, height: 2)
          .foregroundStyle(
            pageIndex >= index ? .csDesert : .gray.opacity(0.1)
          )
          .animation(.easeInOut(duration: 1), value: pageIndex)
      }
    }
    .frame(height: 6)
  }
  
  // MARK: - Next Page Button
  private var nextPageButton: some View {
    Button {
      if pageIndex < pages.count - 1 {
        pageIndex += 1
      } else {
        withAnimation(.easeInOut(duration: 1)) {
          isFinishedOnboarding = true
        }
      }
    } label: {
      Text(isIndexLast ? "Get Started!" : "Continue")
        .font(.poppins(.bold, size: 15))
        .foregroundStyle(isIndexLast ? .black : .white)
        .padding(.vertical,8)
        .padding(.horizontal,50)
    }
    .tint(isIndexLast ? Color.csDesert : Color.csBrown)
    .buttonStyle(.borderedProminent)
  }
}

#Preview {
  OnboardingScreen()
}
