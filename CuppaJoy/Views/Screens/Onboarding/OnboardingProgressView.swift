//
//  OnboardingProgressView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.01.2025.
//

import SwiftUI

struct OnboardingProgressView: View {
  
  let pages = MockData.pages
  @Binding var pageIndex: Int
  
  var body: some View {
    HStack(spacing: 15) {
      ForEach(0..<pages.count, id: \.self) { index in
        ZStack(alignment: .leading) {
          Capsule()
            .frame(width: 25, height: 3)
            .foregroundStyle(.cstGray).opacity(0.1)
          Capsule()
            .frame(width: pageIndex >= index ? 25 : 0, height: 3)
            .foregroundStyle(
              pageIndex == pages.count - 1 ? .cstGreen : .accent
            )
            .animation(.bouncy(duration: 2), value: pageIndex)
        }
      }
    }
    .frame(height: 6)
  }
}

#Preview {
  OnboardingProgressView(pageIndex: .constant(0))
}
