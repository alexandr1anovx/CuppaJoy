//
//  MilkSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Milk: String, CaseIterable {
  case none
  case cows
  case lactose
  case skimmed
  case vegetable
  
  var title: String {
    switch self {
    case .none: "None"
    case .cows: "Cow's"
    case .lactose: "Lactose"
    case .skimmed: "Simmed"
    case .vegetable: "Vegetable"
    }
  }
}

struct MilkPicker: View {
  @State private var milk: Milk = .none
  
  var body: some View {
    Picker("Milk", selection: $milk) {
      ForEach(Milk.allCases, id: \.self) { milk in
        Text(milk.title)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 14))
    .foregroundStyle(.white)
    .tint(.accent)
    .listRowBackground(Color.csDarkBrown)
  }
}
