//
//  IceCubeSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum IceCubeCount: String, CaseIterable {
  case none
  case one
  case two
  
  var title: String { self.rawValue.capitalized }
}

struct IceCubePicker: View {
  @State private var iceCubeCount = IceCubeCount.none
  
  var body: some View {
    Picker("Ice Cube", selection: $iceCubeCount) {
      ForEach(IceCubeCount.allCases, id: \.self) { cubeCount in
        Text(cubeCount.title)
      }
    }
    .pickerStyle(.menu)
    .tint(.accent)
    .font(.subheadline)
    .fontDesign(.monospaced)
  }
}
