//
//  SyrupSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Syrup: String, CaseIterable {
  case none = "None"
  case amaretto = "Amaretto"
  case coconut = "Coconut"
  case vanilla = "Vanilla"
  case caramel = "Caramel"
}

struct SyrupCell: View {
  @State private var syrup: Syrup = .none
  
  var body: some View {
    Picker("Syrup", selection: $syrup) {
      ForEach(Syrup.allCases, id: \.self) { syrup in
        Text(syrup.rawValue)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .tint(.cstCream)
    .listRowBackground(Color.cstBrown)
  }
}
