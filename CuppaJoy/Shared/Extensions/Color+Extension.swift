//
//  Color+Extension.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

extension Color {
  static let appBackground = LinearGradient(
    colors: [.csBlack, .csBrown],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
  )
}

fileprivate struct GradientBackgroundTest: View {
  var body: some View {
    Color.appBackground
  }
}

#Preview {
  GradientBackgroundTest()
}
