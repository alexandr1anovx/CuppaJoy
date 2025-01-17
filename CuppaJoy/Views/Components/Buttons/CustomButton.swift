//
//  BorderedButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct CustomButton: View {
  
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
      .foregroundStyle(.white)
      .padding(15)
      .background(.csBlack)
      .clipShape(.buttonBorder)
  }
}

#Preview {
  CustomButton("Get Started", action: {})
}
