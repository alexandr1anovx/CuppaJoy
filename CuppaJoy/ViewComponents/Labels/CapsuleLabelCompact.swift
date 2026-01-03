//
//  CapsuleLabelCompact.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.04.2025.
//

import SwiftUI

struct CapsuleLabelCompact: View {
  
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
      .font(.subheadline)
      .fontWeight(.medium)
      .foregroundStyle(textColor)
      .padding(12)
      .background {
        Capsule()
          .fill(bgColor)
      }
  }
}

#Preview {
  CapsuleLabelCompact(
    "Save Changes",
    textColor: .accent,
    bgColor: .csBlack
  )
}
