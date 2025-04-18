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
  static let gradientCream = LinearGradient(
    colors: [.csCream],
    startPoint: .topTrailing,
    endPoint: .bottomLeading
  )
  static let gradientBrown = LinearGradient(
    colors: [.csBrown],
    startPoint: .leading,
    endPoint: .trailing
  )
  static let gradientBrownBlack = LinearGradient(
    colors: [.csBrown, .csBlack],
    startPoint: .leading,
    endPoint: .trailing
  )
}
