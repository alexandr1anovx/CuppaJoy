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
  static let appBackgroundDimmed = AngularGradient(
    colors: [.csBrown.opacity(UIConstants.Opacity.semiTransparent), .csBlack],
    center: .trailing,
    angle: .degrees(360)
  )
  static let gradientBrown = LinearGradient(
    colors: [.csBrown],
    startPoint: .leading,
    endPoint: .trailing
  )
}
