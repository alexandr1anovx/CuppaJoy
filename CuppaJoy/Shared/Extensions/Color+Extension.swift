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
  static let mainGradient = LinearGradient(
    colors: [.pink, .purple],
    startPoint: .leading,
    endPoint: .trailing
  )
}
