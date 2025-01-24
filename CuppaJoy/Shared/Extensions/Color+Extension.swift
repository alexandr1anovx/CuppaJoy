//
//  Color+Extension.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

extension Color {
  
  static let mainGradientBackground = LinearGradient(
    colors: [.csDarkBrown, .csBlack],
    startPoint: .topLeading,
    endPoint: .bottomTrailing
  )
  
  static let brownDarkBrownGradient = LinearGradient(
    colors: [.black, .csBrown],
    startPoint: .bottomLeading,
    endPoint: .topTrailing
  )
}
