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
}

struct SyrupPicker: View {
  @State private var syrup: Syrup = .none
  
  var body: some View {
    Picker("Syrup", selection: $syrup) {
      ForEach(Syrup.allCases, id: \.self) { syrup in
        Text(syrup.title)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 14))
    .foregroundStyle(.white)
    .tint(.accent)
    .listRowBackground(Color.csDarkBrown)
  }
}
