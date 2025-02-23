//
//  ButtonStyleLabel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import SwiftUI

struct ButtonLabel: View {
  
  let title: String
  let textColor: Color
  let pouring: Color
  
  init(_ title: String, textColor: Color, pouring: Color) {
    self.title = title
    self.textColor = textColor
    self.pouring = pouring
  }
  
  var body: some View {
    Text(title)
      .font(.subheadline)
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
  ButtonLabel(
    "Continue",
    textColor: .yellow,
    pouring: .black
  )
}
