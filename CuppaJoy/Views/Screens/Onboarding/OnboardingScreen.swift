//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingScreen: View {
  
  @State private var pageIndex = 0
  @State private var isAnimating = false
  @State private var isFinishedOnboarding = false
  
  let pages = OnboardingPage.allCases
  var isIndexLast: Bool { pageIndex == pages.count - 1 }
  
  // MARK: - body
  var body: some View {
    if isFinishedOnboarding {
      EntryPoint()
    } else {
      onboardingPage
    }
  }
  
  // MARK: - Onboarding Page
  private var onboardingPage: some View {
    ZStack(alignment: .bottomTrailing) {
      LinearGradient(
        colors: isIndexLast ? [.csDarkBrown] : [.csBrown, .csBlack],
        startPoint: .bottom,
        endPoint: .center
      )
      .ignoresSafeArea(.all)
      .animation(isIndexLast ? .easeInOut(duration: 1) : .none, value: isIndexLast)
      
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
        .foregroundStyle(.csCreamy)
        .shadow(color: .csCreamy, radius: 3)
      VStack(spacing: 10) {
        Text(page.title)
          .font(.title2)
          .fontWeight(.bold)
          .fontDesign(.rounded)
          .foregroundStyle(.csCreamy)
        Text(page.description)
          .font(.footnote)
          .fontWeight(.medium)
          .fontDesign(.rounded)
          .foregroundStyle(.gray)
          .lineLimit(2)
      }
      .multilineTextAlignment(.center)
    }
    .padding(.horizontal, 20)
    .animation(.easeInOut(duration: isIndexLast ? 1 : 0.6), value: pageIndex)
    .frame(maxWidth: .infinity)
  }
  
  // MARK: - Page Indicator
  private var pageIndicator: some View {
    HStack(spacing: 15) {
      ForEach(0..<pages.count, id: \.self) { index in
        Capsule()
          .frame(width: 20, height: 2)
          .foregroundStyle(pageIndex >= index ? .csCreamy : .gray.opacity(0.1))
          .animation(.easeInOut(duration: 0.5), value: pageIndex)
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
      ZStack {
        Group {
          Circle()
            .frame(width: 60, height: 60)
            .foregroundStyle(.csCreamy)
            .scaleEffect(isAnimating ? 1 : 0, anchor: .leading)
          Circle()
            .frame(width: 54, height: 54)
            .foregroundStyle(isIndexLast ? .csCreamy : .csBrown)
        }
        if isIndexLast {
          Image(.rocket).foregroundStyle(.csBrown)
        } else {
          Image(systemName: "arrowshape.right.fill").foregroundStyle(.csCreamy)
        }
      }
      .onAppear {
        isAnimating = true
      }
      .onChange(of: pageIndex) { oldValue, newValue in
        // Every time the page index changes,
        // the circle scale animation disappears
        // but it restores after 1.5 seconds.
        isAnimating = false
        withAnimation(.easeInOut) { isAnimating = true }
      }
    }
  }
}

#Preview {
  OnboardingScreen()
}
