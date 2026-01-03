//
//  CapsuleLabelWithIconAnimated.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.03.2025.
//

import SwiftUI

struct CapsuleLabelWithIconAnimated: View {
  
  @State private var isAnimating = false
  
  let title: String
  let icon: String
  let textColor: Color
  let bgColor: LinearGradient
  
  init(
    _ title: String,
    icon: String,
    textColor: Color,
    bgColor: LinearGradient
  ) {
    self.title = title
    self.icon = icon
    self.textColor = textColor
    self.bgColor = bgColor
  }
  
  var body: some View {
    Label(title, systemImage: icon)
      .font(.callout)
      .fontWeight(.medium)
      .foregroundStyle(textColor)
      .frame(maxWidth: .infinity)
      .padding(.vertical,16)
      .background {
        Capsule()
          .fill(bgColor)
          .shadow(radius: 3)
      }
      .padding(.horizontal,30)
      .scaleEffect(isAnimating ? UIConstants.Scale.iconPressed : UIConstants.Scale.profileImageReset)
      .onAppear {
        withAnimation(.easeInOut(duration: 2).repeatForever()) {
          isAnimating.toggle()
        }
      }
  }
}

#Preview {
  CapsuleLabelWithIconAnimated(
    "Confirm",
    icon: "checkmark.circle.fill",
    textColor: .white,
    bgColor: Color.gradientBrown
  )
}
