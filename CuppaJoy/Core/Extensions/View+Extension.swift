//
//  View+Extension.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 14.04.2025.
//

import SwiftUI

extension View {
  
  func customListStyle(
    rowSpacing: CGFloat? = 0,
    shadowRadius: CGFloat? = 0
  ) -> some View {
    self
      .listStyle(.insetGrouped)
      .listRowSpacing(rowSpacing)
      //.scrollIndicators(.hidden)
      .scrollContentBackground(.hidden)
      .shadow(radius: shadowRadius ?? 0)
  }
  
  func setupSegmentedControlAppearance() {
    let appearance = UISegmentedControl.appearance()
    appearance.selectedSegmentTintColor = .csBrown
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    appearance.backgroundColor = .black
  }
}
