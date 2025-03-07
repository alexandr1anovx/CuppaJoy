//
//  ButtonLabelWithIconAnimated.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.03.2025.
//

import SwiftUI

struct ButtonLabelWithIconAnimated: View {
  
  @State private var isAnimating = false
  
  let title: String
  let icon: String
  let textColor: Color
  let bgColor: LinearGradient
  
  init(_ title: String, icon: String, textColor: Color, bgColor: LinearGradient) {
    self.title = title
    self.icon = icon
    self.textColor = textColor
    self.bgColor = bgColor
  }
  
  var body: some View {
    Label(title, systemImage: icon)
      .font(.subheadline)
      .fontWeight(.semibold)
      .foregroundStyle(textColor)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 16)
      .background(bgColor)
      .clipShape(.rect(cornerRadius: 15))
      .padding(.horizontal, 20)
      .shadow(radius: 5)
      .scaleEffect(isAnimating ? 0.95 : 1)
      .onAppear {
        withAnimation(.easeInOut(duration: 2).repeatForever()) {
          isAnimating.toggle()
        }
      }
  }
}

#Preview {
  ButtonLabelWithIconAnimated(
    "Confirm",
    icon: "checkmark",
    textColor: .white,
    bgColor: Color.brownGradient
  )
}
