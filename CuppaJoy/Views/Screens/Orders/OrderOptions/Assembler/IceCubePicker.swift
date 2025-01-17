//
//  IceCubeSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum IceCube: String, CaseIterable {
  case none
  case one
  case two
  
  var title: String { self.rawValue.capitalized }
}

struct IceCubePicker: View {
  @State private var iceCubeCount: IceCube = .none
  
  var body: some View {
    Picker("Ice Cube", selection: $iceCubeCount) {
      ForEach(IceCube.allCases, id: \.self) { cube in
        Text(cube.title)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 14))
    .foregroundStyle(.white)
    .tint(.accent)
    .listRowBackground(Color.csDarkBrown)
  }
}
