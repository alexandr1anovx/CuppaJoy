//
//  OnboardingScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 11.01.2025.
//

import SwiftUI

struct OnboardingScreen: View {
  
  @State private var pageIndex: Int = 0
  @State private var isFinished: Bool = false
  let pages = MockData.pages
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      if isFinished {
        SignInScreen()
      } else {
        VStack(spacing: 40) {
          Spacer()
          OnboardingDataView(pageIndex: pageIndex)
          OnboardingProgressView(pageIndex: $pageIndex)
          Spacer()
        }
        OnboardingNextButton(
          pageIndex: $pageIndex,
          color: pages[pageIndex].color
        ) {
          if pageIndex < pages.count - 1 {
            pageIndex += 1
          } else {
            withAnimation {
              isFinished = true
            }
          }
        }
        .padding()
      }
    }
  }
}

#Preview {
  OnboardingScreen()
}
