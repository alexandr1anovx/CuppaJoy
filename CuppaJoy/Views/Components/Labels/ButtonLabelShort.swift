//
//  ButtonLabelShort.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.04.2025.
//

import SwiftUI

struct ButtonLabelShort: View {
  
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
      .fontWeight(.semibold)
      .foregroundStyle(textColor)
      .padding(.horizontal,20)
      .padding(.vertical,13)
      .background(bgColor)
      .clipShape(.capsule)
      .shadow(radius: 3)
  }
}

#Preview {
  ButtonLabelShort(
    "Save Changes",
    textColor: .white,
    bgColor: .blue
  )
}
