//
//  BorderedButton.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 12.10.2024.
//

import SwiftUI

struct CSButton: View {
  
  let title: String
  let action: () -> Void
  
  init(_ title: String, action: @escaping () -> Void) {
    self.title = title
    self.action = action
  }
  
  var body: some View {
    Button {
      action()
    } label: {
      Text(title)
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 20)
    }
    .tint(.black)
    .buttonStyle(.borderedProminent)
  }
}

#Preview {
  CSButton("Get Started", action: {})
}
