//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

enum OnboardingPage: Int, CaseIterable {
  case page1
  case page2
  case page3
  
  var title: String {
    switch self {
    case .page1: "Welcome to Cuppa Joy"
    case .page2: "A World of Flavors"
    case .page3: "Welcome to the Cuppa Joy App!"
    }
  }
  
  var description: String {
    switch self {
    case .page1: "Discover the perfect cup of coffee, crafted just for you."
    case .page2: "Explore our curated selection of beans from around the globe."
    case .page3: "Your coffee experience just got smarter! Let’s brew something amazing together."
    }
  }
  
  var imageName: String {
    switch self {
    case .page1: "coffee2"
    case .page2: "coffee2"
    case .page3: "coffee2"
    }
  }
}

struct OnboardingScreen: View {
  @State private var pageIndex = 0
  @State private var isAnimating = false
  @State private var isFinished = false
  
  var isIndexLast: Bool { pageIndex == pages.count - 1 }
  let pages = OnboardingPage.allCases
  
  // MARK: - body
  var body: some View {
    if isFinished {
      EntryPoint()
    } else {
      ZStack(alignment: .bottomTrailing) {
        VStack {
          TabView(selection: $pageIndex) {
            ForEach(pages, id: \.rawValue) { page in
              pageContentView(for: page)
            }
          }
        }
        nextPageButton.padding(25)
      }
    }
  }
  
  // MARK: - Page Content View
  private func pageContentView(for page: OnboardingPage) -> some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack(spacing: 30) {
        Image(page.imageName)
          .resizable()
          .frame(width: 150, height: 150)
        VStack(spacing: 10) {
          Text(page.title)
            .font(.poppins(.bold, size: 17))
            .foregroundStyle(isIndexLast ? .csYellow : .accent)
          Text(page.description)
            .font(.poppins(.medium, size: 12))
            .foregroundStyle(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
        }
        pageIndicator
      }
    }
  }
  
  // MARK: - Page Indicator
  private var pageIndicator: some View {
    HStack(spacing: 15) {
      ForEach(0..<pages.count, id: \.self) { currentIndex in
        Circle()
          .fill(pageIndex == currentIndex
            ? (currentIndex == pages.count - 1 ? Color.csYellow : Color.accent)
            : Color.gray.opacity(0.5)
          )
          .frame(
            width: pageIndex == currentIndex ? 12 : 8,
            height: pageIndex == currentIndex ? 12 : 8
          )
      }
    }
  }
  
  // MARK: - Next Page Button
  private var nextPageButton: some View {
    Button {
      withAnimation {
        if pageIndex < pages.count - 1 {
          pageIndex += 1
        } else {
          withAnimation(.spring(duration: 1)) {
            isFinished = true
          }
        }
      }
    } label: {
      ZStack {
        Group {
          Circle()
            .frame(width: 60, height: 60)
            .foregroundStyle(isIndexLast ? .csYellow : .accent)
            .scaleEffect(isAnimating ? 1 : 0, anchor: .leading)
          Circle()
            .frame(width: 54, height: 54)
            .foregroundStyle(isIndexLast ? .csYellow : .csBrown)
        }
        
        if isIndexLast {
          Image(.rocket).foregroundStyle(.black)
        } else {
          Image(.paw).foregroundStyle(.accent)
        }
      }
      .onChange(of: pageIndex) { oldValue, newValue in
        isAnimating.toggle()
        
        withAnimation(.spring(duration: 1)) {
          isAnimating.toggle()
        }
      }
      .onAppear {
        withAnimation(.spring(duration: 1)) {
          isAnimating.toggle()
        }
      }
    }
  }
}

#Preview {
  OnboardingScreen()
}
