//
//  IceCubeSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum IceCube: String, CaseIterable {
  case none = "None"
  case one = "One cube"
  case two = "Two cubes"
  case three = "Three cubes"
}

struct IceCubePicker: View {
  @State private var iceCubeCount: IceCube = .none
  
  var body: some View {
    Picker("Ice Cube", selection: $iceCubeCount) {
      ForEach(IceCube.allCases, id: \.self) { iceCube in
        Text(iceCube.rawValue)
          .foregroundStyle(.cstCream)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .tint(.cstCream)
    .listRowBackground(Color.cstBrown)
  }
}
