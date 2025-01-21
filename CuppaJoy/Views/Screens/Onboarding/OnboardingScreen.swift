//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingScreen: View {
  
  @State private var pageIndex = 0
  @State private var isAnimatingCircle = false
  @State private var isAnimatingImage = false
  @State private var isOnboardingFinished = false
  
  let pages = OnboardingPage.allCases
  var isIndexLast: Bool { pageIndex == pages.count - 1 }
  
  // MARK: - body
  var body: some View {
    if isOnboardingFinished {
      EntryPoint()
    } else {
      onboardingPage
    }
  }
  
  // MARK: - Onboarding Page
  private var onboardingPage: some View {
    ZStack(alignment: .bottomTrailing) {
      Color.brownDarkBrownGradient.ignoresSafeArea()
//      LinearGradient(
//        colors: [.csBrown, .csDarkBrown],
//        startPoint: .bottomLeading,
//        endPoint: .topLeading
//      ).ignoresSafeArea(.all)
      
      VStack(spacing: 20) {
        Spacer()
        pageData(for: pages[pageIndex])
        pageIndicator
        Spacer()
      }
      nextPageButton.padding(25)
    }
  }
  
  // MARK: - Page Data
  private func pageData(for page: OnboardingPage) -> some View {
    VStack(spacing: 20) {
      Image(page.image)
        .resizable()
        .frame(width: 140, height: 140)
        .foregroundStyle(isIndexLast ? .csMint : .csCreamy)
        .shadow(color: isIndexLast ? .csMint : .csCreamy, radius: 3)
        .scaleEffect(isAnimatingImage ? 0.9 : 1)
      VStack(alignment: .center, spacing: 10) {
        Text(page.title)
          .font(.poppins(.bold, size: 17))
          .foregroundStyle(isIndexLast ? .csMint : .csCreamy)
        Text(page.description)
          .font(.poppins(.medium, size: 13))
          .foregroundStyle(.gray)
          .multilineTextAlignment(.center)
          .lineLimit(2)
      }
    }
    .padding(.horizontal, 40)
    .animation(.easeInOut, value: pageIndex)
    .frame(maxWidth: .infinity, minHeight: 250)
  }
  
  // MARK: - Page Indicator
  private var pageIndicator: some View {
    HStack(spacing: 15) {
      ForEach(0..<pages.count, id: \.self) { index in
        ZStack {
          Capsule()
            .frame(width: 25, height: 2.5)
            .foregroundStyle(.gray).opacity(0.1)
          Capsule()
            .frame(width: pageIndex >= index ? 25 : 0, height: 2.5)
            .foregroundStyle(isIndexLast ? .csMint : .csCreamy).opacity(0.8)
            .animation(.spring, value: pageIndex)
        }
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
        withAnimation(.spring(duration: 1)) {
          isOnboardingFinished = true
        }
      }
    } label: {
      ZStack {
        Group {
          Circle()
            .frame(width: 60, height: 60)
            .foregroundStyle(isIndexLast ? .csMint : .csCreamy)
            .scaleEffect(isAnimatingCircle ? 1 : 0, anchor: .leading)
          Circle()
            .frame(width: 54, height: 54)
            .foregroundStyle(isIndexLast ? .csMint : .csBrown)
            .shadow(color: isIndexLast ? .csMint : .csCreamy, radius: 5)
        }
        if isIndexLast {
          Image(.rocket).foregroundStyle(.csBrown)
        } else {
          Image(systemName: "arrowshape.right.fill")
            .foregroundStyle(.csCreamy)
        }
      }
      .onChange(of: pageIndex) { oldValue, newValue in
        // Every time the page index changes,
        // the circle scale animation disappears
        // but it restores after 1.5 seconds.
        isAnimatingCircle = false
        withAnimation(.spring) { isAnimatingCircle = true }
      }
      .onAppear {
        isAnimatingCircle = true
        withAnimation(.easeInOut(duration:2).repeatForever()) {
          isAnimatingImage = true
        }
      }
    }
  }
}

#Preview {
  OnboardingScreen()
}
