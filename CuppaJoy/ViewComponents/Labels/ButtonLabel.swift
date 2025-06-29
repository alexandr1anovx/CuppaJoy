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
      .background(bgColor)
      .clipShape(.rect(cornerRadius: 15))
      .padding(.horizontal,20)
      .shadow(radius: 5)
  }
}

#Preview {
  ButtonLabel(
    "Continue",
    textColor: .yellow,
    bgColor: .black
  )
}
