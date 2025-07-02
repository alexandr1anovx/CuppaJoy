//
//  View+Extension.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 14.04.2025.
//

import SwiftUI

extension View {
  
  func customListStyle(
    minRowHeight: CGFloat = 0,
    rowSpacing: CGFloat = 0,
    sectionSpacing: CGFloat = 0,
    scrollDisabled: Bool = false,
    indicators: ScrollIndicatorVisibility = .hidden,
    height: CGFloat? = nil,
    shadow: CGFloat = 0
  ) -> some View {
    self
      .listStyle(.insetGrouped)
      .environment(\.defaultMinListRowHeight, minRowHeight)
      .listRowSpacing(rowSpacing)
      .listSectionSpacing(sectionSpacing)
      .scrollContentBackground(.hidden)
      .scrollDisabled(scrollDisabled)
      .scrollIndicators(indicators)
      .frame(height: height)
      .shadow(radius: shadow)
  }
  
  func setupSegmentedControlAppearance() {
    let appearance = UISegmentedControl.appearance()
    appearance.selectedSegmentTintColor = .csBrown
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    appearance.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    appearance.backgroundColor = .black
  }
}
