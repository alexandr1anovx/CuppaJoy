//
//  CapsuleLabelAnimated.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.02.2025.
//

import SwiftUI

struct CapsuleLabelAnimated: View {
  
  @State private var isAnimating = false
  let title: String
  let textColor: Color
  let bgColor: LinearGradient
  
  init(
    _ title: String,
    textColor: Color,
    bgColor: LinearGradient
  ) {
    self.title = title
    self.textColor = textColor
    self.bgColor = bgColor
  }
  
  var body: some View {
    Text(title)
      .font(.callout)
      .fontWeight(.medium)
      .foregroundStyle(textColor)
      .frame(maxWidth: .infinity)
      .padding(.vertical,16)
      .background {
        Capsule()
          .fill(bgColor)
          .padding(.horizontal,30)
          .shadow(radius: 5)
      }
      .scaleEffect(isAnimating ? UIConstants.Scale.buttonPressed : UIConstants.Scale.profileImageReset)
      .onAppear {
        withAnimation(.easeInOut(duration: 1.8).repeatForever()) {
          isAnimating.toggle()
        }
      }
  }
}

#Preview {
  CapsuleLabelAnimated(
    "Check Order Details",
    textColor: .white,
    bgColor: Color.gradientBrown
  )
}
