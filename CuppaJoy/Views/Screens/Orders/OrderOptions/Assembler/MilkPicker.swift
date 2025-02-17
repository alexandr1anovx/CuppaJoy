//
//  MilkSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Milk: String, CaseIterable {
  case none
  case cow
  case lactose
  
  var title: String {
    switch self {
    case .none: "None"
    case .cow: "Cow's"
    case .lactose: "Lactose"
    }
  }
  
  var price: Double {
    switch self {
    case .none: 0.0
    case .cow: 1.0
    case .lactose: 3.0
    }
  }
}

struct MilkPicker: View {
  @Binding var milk: Milk
  
  var body: some View {
    Picker("Milk", selection: $milk) {
      ForEach(Milk.allCases, id: \.self) { milk in
        Text(milk.title)
      }
    }
    .pickerStyle(.menu)
    .tint(.accent)
    .font(.subheadline)
    .fontDesign(.monospaced)
  }
}
