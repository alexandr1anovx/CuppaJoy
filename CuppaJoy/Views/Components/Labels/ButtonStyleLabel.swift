//
//  ButtonStyleLabel.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 19.02.2025.
//

import SwiftUI

struct ButtonStyleLabel: View {
  
  let title: String
  let bgColor: Color
  
  init(_ title: String, bgColor: Color) {
    self.title = title
    self.bgColor = bgColor
  }
  
  var body: some View {
    Text(title)
      .font(.system(size: 17, weight: .bold))
      .foregroundStyle(.csCream)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 16)
      .background(bgColor)
      .clipShape(.buttonBorder)
  }
}

#Preview {
  ButtonStyleLabel("Continue", bgColor: .black)
}
