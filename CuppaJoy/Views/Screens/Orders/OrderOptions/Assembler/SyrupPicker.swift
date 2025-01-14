//
//  SyrupSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Syrup: String, CaseIterable {
  case none, amaretto, coconut, vanilla, caramel
}

struct SyrupPicker: View {
  @State private var syrup: Syrup = .none
  
  var body: some View {
    Picker("Syrup", selection: $syrup) {
      ForEach(Syrup.allCases, id: \.self) { syrup in
        Text(syrup.rawValue.capitalized)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .tint(.accent)
    .listRowBackground(Color.cstBrown)
  }
}
