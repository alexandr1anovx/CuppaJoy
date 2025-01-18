//
//  Font+Extension.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.10.2024.
//

import SwiftUI

extension Font {
  
  enum PoppinsFont {
    case regular
    case medium
    case bold
    
    var value: String {
      switch self {
      case .regular: "Poppins-Regular"
      case .medium: "Poppins-Medium"
      case .bold: "Poppins-Bold"
      }
    }
  }
  
  static func poppins(_ type: PoppinsFont, size: CGFloat = 16) -> Font {
    return .custom(type.value, size: size)
  }
}
