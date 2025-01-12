//
//  OnboardingDataView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.01.2025.
//

import SwiftUI

struct OnboardingDataView: View {
  
  let pages = MockData.pages
  let pageIndex: Int
  
  var body: some View {
    VStack(spacing: 20) {
      
      Image(pages[pageIndex].image)
        .resizable()
        .frame(width: 120, height: 120)
        .foregroundStyle(.cstBrown)
      
      Text(pages[pageIndex].title)
        .font(.poppins(.bold, size: 17))
        .foregroundStyle(
          pageIndex == MockData.pages.count - 1 ? .cstGreen : .cstWhite
        )
      
      Text(pages[pageIndex].description)
        .font(.poppins(.medium, size: 12))
        .foregroundStyle(.cstGray)
        .multilineTextAlignment(.center)
        .padding(.horizontal,40)
    }
    .id(pageIndex)
    .transition(.move(edge: .trailing))
    .animation(.bouncy(duration: 1), value: pageIndex)
    .frame(maxWidth: .infinity)
  }
}

#Preview {
  OnboardingDataView(pageIndex: 0)
}
