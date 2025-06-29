//
//  ButtonLabelAnimated.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.02.2025.
//

import SwiftUI

struct ButtonLabelAnimated: View {
  
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
      .padding(.vertical,15)
      .background(bgColor)
      .clipShape(.rect(cornerRadius: 15))
      .padding(.horizontal,20)
      .shadow(radius: 5)
      .scaleEffect(isAnimating ? 0.95 : 1)
      .onAppear {
        withAnimation(.easeInOut(duration: 1.8).repeatForever()) {
          isAnimating.toggle()
        }
      }
  }
}

#Preview {
  ButtonLabelAnimated(
    "Check Order Details",
    textColor: .white,
    bgColor: Color.gradientBrown
  )
}
