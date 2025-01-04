//
//  TypeSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum CoffeeType: String, CaseIterable {
  case arabica, robusta, excelsa, liberica
}

struct CoffeeTypePicker: View {
  @State private var coffeeType: CoffeeType = .arabica
  
  var body: some View {
    Picker("Type", selection: $coffeeType) {
      ForEach(CoffeeType.allCases, id: \.self) { type in
        Text(type.rawValue.capitalized)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .tint(.cstCream)
    .listRowBackground(Color.cstBrown)
  }
}

#Preview {
  CoffeeTypePicker()
}
