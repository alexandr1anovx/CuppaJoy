//
//  ButtonLabelWithIcon.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.02.2025.
//

import SwiftUI

struct ButtonLabelWithIcon: View {
  
  let title: String
  let icon: String
  let textColor: Color
  let pouring: Color
  
  init(
    _ title: String,
    icon: String,
    textColor: Color,
    pouring: Color
  ) {
    self.title = title
    self.icon = icon
    self.textColor = textColor
    self.pouring = pouring
  }
  
  var body: some View {
    Label(title, systemImage: icon)
      .font(.headline)
      .fontWeight(.bold)
      .foregroundStyle(textColor)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 16)
      .background(pouring)
      .clipShape(.rect(cornerRadius: 15))
      .padding(.horizontal, 20)
      .shadow(radius: 5)
  }
}

#Preview {
  ButtonLabelWithIcon(
    "Continue",
    icon: "arrow.right",
    textColor: .white,
    pouring: .blue
  )
}
