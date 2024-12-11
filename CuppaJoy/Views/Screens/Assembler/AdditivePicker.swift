//
//  AdditiveSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Additive: String, CaseIterable {
  case none = "None"
  case ceylonCinnamon = "Ceylon cinnamon"
  case gratedChocolate = "Grated chocolate"
  case liquidChocolate = "Liquid chocolate"
  case marshmallow = "Marshmallow"
  case cream = "Cream"
  case iceCream = "Ice cream"
}

struct AdditivePicker: View {
  @State private var additive: Additive = .none
  
  var body: some View {
    Picker("Additives", selection: $additive) {
      ForEach(Additive.allCases, id: \.self) { additive in
        Text(additive.rawValue)
          .foregroundStyle(.cstCream)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .tint(.cstCream)
    .listRowBackground(Color.cstBrown)
  }
}
