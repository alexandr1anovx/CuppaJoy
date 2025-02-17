//
//  CupSizeCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

enum CupSize: String, CaseIterable {
  case small
  case medium
  case large
  
  var title: String { self.rawValue.capitalized }
  
  var price: Double {
    switch self {
    case .small: 0.0
    case .medium: 1.5
    case .large: 3.0
    }
  }
}

struct CupSizeCell: View {
  @Binding var cupSize: CupSize
  
  init(cupSize: Binding<CupSize>) {
    self._cupSize = cupSize
    
    // Custom Picker Style
    UISegmentedControl.appearance().selectedSegmentTintColor = .csBrown
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
    UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    UISegmentedControl.appearance().backgroundColor = .black
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Size:")
        .font(.subheadline)
        .fontDesign(.monospaced)
      Picker("", selection: $cupSize) {
        ForEach(CupSize.allCases, id: \.self) { size in
          Text(size.title)
        }
      }.pickerStyle(.segmented)
    }
  }
}

#Preview {
  CupSizeCell(cupSize: .constant(.medium))
}
