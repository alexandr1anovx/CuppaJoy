//
//  BorderedButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct CustomBtn: View {
  let title: String
  let action: () -> Void
  
  init(_ title: String, action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
  
  var body: some View {
    Button(title, action: action)
      .frame(minWidth: 50)
      .font(.poppins(.medium, size: 15))
      .foregroundStyle(.cstDarkBrown)
      .padding(13)
      .background(Color.cstCream.shadow(.inner(radius: 3)))
      .clipShape(.buttonBorder)
  }
}

#Preview {
  CustomBtn("Get Started", action: {})
}
