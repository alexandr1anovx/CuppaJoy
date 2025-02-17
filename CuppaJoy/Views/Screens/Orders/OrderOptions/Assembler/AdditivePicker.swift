//
//  AdditiveSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Additive: String, CaseIterable {
  case none
  case darkChocolate
  case milkChocolate
  
  var title: String {
    switch self {
    case .none: "None"
    case .darkChocolate: "Dark Chocolate"
    case .milkChocolate: "Milk Chocolate"
    }
  }
  
  var price: Double {
    switch self {
    case .none: 0.0
    case .darkChocolate: 1.0
    case .milkChocolate: 1.5
    }
  }
}

struct AdditivePicker: View {
  @Binding var additive: Additive
  
  var body: some View {
    Picker("Additive", selection: $additive) {
      ForEach(Additive.allCases, id: \.self) { additive in
        Text(additive.title)
      }
    }
    .pickerStyle(.menu)
    .tint(.accent)
    .font(.subheadline)
    .fontDesign(.monospaced)
  }
}

#Preview {
  AdditivePicker(additive: .constant(.darkChocolate))
}
