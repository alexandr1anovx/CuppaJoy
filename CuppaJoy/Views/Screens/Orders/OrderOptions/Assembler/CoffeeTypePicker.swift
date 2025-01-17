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
  @State private var coffeeType: CoffeeType = .arabica
  
  var body: some View {
    Picker("Type", selection: $coffeeType) {
      ForEach(CoffeeType.allCases, id: \.self) { coffeeType in
        Text(coffeeType.title)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 14))
    .foregroundStyle(.white)
    .tint(.accent)
    .listRowBackground(Color.csDarkBrown)
  }
}

#Preview {
  CoffeeTypePicker()
}
