//
//  AdditiveSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Additive: String, CaseIterable {
  case none
  case gratedChocolate
  case liquidChocolate
  case marshmallow
  case cream
  
  var title: String {
    switch self {
    case .none: "None"
    case .gratedChocolate: "Grated Chocolate"
    case .liquidChocolate: "Liquid Chocolate"
    case .marshmallow: "Marshmallow"
    case .cream: "Cream"
    }
  }
}

struct AdditivePicker: View {
  @State private var additive: Additive = .none
  
  var body: some View {
    Picker("Additive", selection: $additive) {
      ForEach(Additive.allCases, id: \.self) { additive in
        Text(additive.title)
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
  AdditivePicker()
}
