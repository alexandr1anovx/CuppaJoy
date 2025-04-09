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
  static let creamGradient = LinearGradient(
    colors: [.csCream],
    startPoint: .topTrailing,
    endPoint: .bottomLeading
  )
  static let brownGradient = LinearGradient(
    colors: [.csBrown],
    startPoint: .leading,
    endPoint: .trailing
  )
  static let pointsGradient = LinearGradient(
    colors: [.csBrown, .csBlack],
    startPoint: .leading,
    endPoint: .trailing
  )
}
