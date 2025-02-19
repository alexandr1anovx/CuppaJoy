//
//  BorderedButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct CSButton: View {
  
  let title: String
  let bgColor: Color
  let action: () -> Void
  
  init(_ title: String, bgColor: Color, action: @escaping () -> Void) {
    self.title = title
    self.bgColor = bgColor
    self.action = action
  }
  
  var body: some View {
    Button(action: action) {
      Text(title)
        .font(.callout).bold()
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
    .buttonStyle(.borderedProminent)
    .tint(bgColor)
    .padding(.horizontal, 20)
  }
}

#Preview {
  CSButton("Get Started", bgColor: .csDesert, action: {})
}
