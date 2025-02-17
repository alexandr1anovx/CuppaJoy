//
//  SyrupSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Syrup: String, CaseIterable {
  case none
  case amaretto
  case coconut
  case vanilla
  case caramel
  
  var title: String { self.rawValue.capitalized }
  
  var price: Double {
    switch self {
    case .none: 0.0
    case .amaretto: 1.0
    case .coconut: 1.5
    case .vanilla: 1.0
    case .caramel: 2.0
    }
  }
}

struct SyrupPicker: View {
  @Binding var syrup: Syrup
  
  var body: some View {
    Picker("Syrup", selection: $syrup) {
      ForEach(Syrup.allCases, id: \.self) { syrup in
        Text(syrup.title)
      }
    }
    .pickerStyle(.menu)
    .tint(.accent)
    .font(.subheadline)
    .fontDesign(.monospaced)
  }
}
