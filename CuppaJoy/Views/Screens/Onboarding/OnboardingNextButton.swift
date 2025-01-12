//
//  OnboardingNextButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.01.2025.
//

import SwiftUI

struct OnboardingNextButton: View {
  
  @State private var isShownAnimatedCircle: Bool = false
  @Binding var pageIndex: Int
  let pages = MockData.pages
  let color: Color
  let action: () -> Void
  
  var body: some View {
    ZStack {
      Group {
        Circle()
          .frame(width: 60, height: 60)
          .foregroundStyle(color)
          .scaleEffect(
            isShownAnimatedCircle ? 1 : 0, anchor: .leading
          )
        Circle()
          .frame(width: 54, height: 54)
          .foregroundStyle(.cstBrown)
      }
      
      if pageIndex == pages.count - 1 {
        Image(systemName: "checkmark.seal.fill")
          .font(.title3)
          .foregroundStyle(color)
      } else {
        Image(systemName: "arrow.right")
          .font(.title3)
          .foregroundStyle(color)
      }
    }
    .frame(
      maxWidth: .infinity,
      maxHeight: .infinity,
      alignment: .bottomTrailing
    )
    .padding(.horizontal)
    
    .onTapGesture {
      action() // Shows the next view.
    }
    .onChange(of: pageIndex) { oldValue, newValue in
      // Redraws the arrow button each time the onboarding view changes.
      isShownAnimatedCircle.toggle()
      withAnimation(.bouncy(duration: 2)) {
        isShownAnimatedCircle.toggle()
      }
    }
    .onAppear {
      withAnimation(.bouncy(duration: 2)) {
        isShownAnimatedCircle.toggle()
      }
    }
  }
}

#Preview {
  OnboardingNextButton(
    pageIndex: .constant(0),
    color: .orange,
    action: {}
  )
}
