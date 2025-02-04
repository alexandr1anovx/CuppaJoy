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
  case lactose = "Lactose"
}

struct MilkPicker: View {
  @State private var selectedMilk = Milk.none
  
  var body: some View {
    Picker("Milk", selection: $selectedMilk) {
      ForEach(Milk.allCases, id: \.self) { milk in
        Text(milk.rawValue)
      }
    }
    .pickerStyle(.menu)
    .tint(.accent)
    .font(.subheadline)
    .fontDesign(.monospaced)
  }
}
