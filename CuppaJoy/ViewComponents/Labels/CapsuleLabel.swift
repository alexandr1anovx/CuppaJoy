//
//  ButtonStyleLabel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import SwiftUI

struct CapsuleLabel: View {
  
  let title: String
  let textColor: Color
  let bgColor: Color
  
  init(_ title: String, textColor: Color, bgColor: Color) {
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
      .background {
        Capsule()
          .fill(bgColor)
          .padding(.horizontal,20)
          .shadow(radius: 3)
      }
  }
}

#Preview {
  CapsuleLabel(
    "Continue",
    textColor: .accent,
    bgColor: .csBlack
  )
}
