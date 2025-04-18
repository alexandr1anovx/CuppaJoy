//
//  ButtonLabelWithIconShort.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 14.04.2025.
//

import SwiftUI

struct ButtonLabelWithIconShort: View {
  let title: String
  let iconName: String
  let textColor: Color
  let bgColor: Color
  
  init(
    _ title: String,
    icon: String,
    textColor: Color,
    bgColor: Color
  ) {
    self.title = title
    self.iconName = icon
    self.textColor = textColor
    self.bgColor = bgColor
  }
  
  var body: some View {
    Label(title, systemImage: iconName)
      .font(.subheadline)
      .fontWeight(.medium)
      .foregroundStyle(textColor)
      .padding(11)
      .background(bgColor)
      .clipShape(.capsule)
      .shadow(radius: 3)
  }
}

#Preview {
  ButtonLabelWithIconShort(
    "Add",
    icon: "plus.circle.fill",
    textColor: .orange,
    bgColor: .csDarkGrey
  )
  ButtonLabelWithIconShort(
    "Ongoing",
    icon: "cart.badge.clock",
    textColor: .orange,
    bgColor: .csDarkGrey
  )
  ButtonLabelWithIconShort(
    "Received",
    icon: "cart.fill",
    textColor: .orange,
    bgColor: .csDarkGrey
  )
}
