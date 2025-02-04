//
//  AdditiveSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Additive: String, CaseIterable {
  case none = "None"
  case darkChocolate = "Dark Chocolate"
  case milkChocolate = "Milk Chocolate"
}

struct AdditivePicker: View {
  @State private var selectedAdditive = Additive.none
  
  var body: some View {
    Picker("Additive", selection: $selectedAdditive) {
      ForEach(Additive.allCases, id: \.self) { additive in
        Text(additive.rawValue)
      }
    }
    .pickerStyle(.menu)
    .tint(.accent)
    .font(.subheadline)
    .fontDesign(.monospaced)
  }
}

#Preview {
  AdditivePicker()
}
