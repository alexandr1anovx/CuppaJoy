//
//  MilkSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Milk: String, CaseIterable {
  case none = "None"
  case cows = "Cow's"
  case lactose = "Lactose-free"
  case skimmed = "Skimmed"
  case vegetable = "Vegetable"
}

struct MilkPicker: View {
  @State private var milk: Milk = .none
  
  var body: some View {
    Picker("Milk", selection: $milk) {
      ForEach(Milk.allCases, id: \.self) { milk in
        Text(milk.rawValue)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .tint(.accent)
    .listRowBackground(Color.cstBrown)
  }
}
