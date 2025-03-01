//
//  ButtonLabelWithIconAnimated.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 01.03.2025.
//

import SwiftUI

struct ButtonLabelWithIconAnimated: View {
  
  @State private var isEnable = false
  
  let title: String
  let icon: String
  let textColor: Color
  
  init(_ title: String, icon: String, textColor: Color) {
    self.title = title
    self.icon = icon
    self.textColor = textColor
  }
  
  var body: some View {
    Text("Hello, World!")
  }
}

#Preview {
  ButtonLabelWithIconAnimated(
    "Confirm",
    icon: "checkmark",
    textColor: .white
  )
}
