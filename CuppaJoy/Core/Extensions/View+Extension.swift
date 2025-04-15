//
//  View+Extension.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 14.04.2025.
//

import SwiftUI

extension View {
  func customListStyle() -> some View {
    self
      .listStyle(.insetGrouped)
      .listRowSpacing(15)
      .scrollIndicators(.hidden)
      .scrollContentBackground(.hidden)
      .shadow(radius:5)
  }
}
