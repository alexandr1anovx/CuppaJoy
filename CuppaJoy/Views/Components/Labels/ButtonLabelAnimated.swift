//
//  ButtonLabelAnimated.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.02.2025.
//

import SwiftUI

struct ButtonLabelAnimated: View {
  
  @State private var isEnable = false
  
  let title: String
  let textColor: Color
  
  init(_ title: String, textColor: Color) {
    self.title = title
    self.textColor = textColor
  }
  
  var body: some View {
    Text(title)
      .font(.subheadline)
      .fontWeight(.bold)
      .foregroundStyle(.white)
      .frame(maxWidth: .infinity)
      .padding(.vertical, 16)
      
      .background(Color.mainGradient)
      .hueRotation(.degrees(isEnable ? 40 : 0))
      .onAppear {
        withAnimation(.easeInOut(duration: 2).repeatForever()) {
          isEnable.toggle()
        }
      }
      
      .clipShape(.rect(cornerRadius: 15))
      .padding(.horizontal, 20)
      .shadow(radius: 5)
      .scaleEffect(isEnable ? 0.95 : 1)
  }
}

#Preview {
  ButtonLabelAnimated(
    "Check Order Details",
    textColor: .white
  )
}
