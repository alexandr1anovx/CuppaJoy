//
//  TypeSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum CoffeeType: String, CaseIterable {
  case arabica
  case robusta
  case excelsa
  case liberica
  
  var title: String { self.rawValue.capitalized }
}

struct CoffeeTypePicker: View {
  @Binding var coffeeType: CoffeeType
  
  var body: some View {
    Picker("Type", selection: $coffeeType) {
      ForEach(CoffeeType.allCases, id: \.self) { type in
        Text(type.title)
      }
    }
    .pickerStyle(.menu)
    .tint(.accent)
    .font(.subheadline)
    .fontDesign(.monospaced)
  }
}

#Preview {
  CoffeeTypePicker(coffeeType: .constant(.robusta))
}
