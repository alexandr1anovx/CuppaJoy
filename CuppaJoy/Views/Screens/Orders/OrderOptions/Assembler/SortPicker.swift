//
//  SortSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Sort: String, CaseIterable {
  case santos
  case bourbonSantos
  case minas
  case rio
  case canilon
  case flatBeat
  
  var title: String {
    switch self {
    case .santos: "Santos"
    case .bourbonSantos: "Bourbon Santos"
    case .minas: "Minas"
    case .rio: "Rio"
    case .canilon: "Canilon"
    case .flatBeat: "Flat Beat"
    }
  }
}

struct SortPicker: View {
  @State private var sort: Sort = .santos
  
  var body: some View {
    Picker("Sort", selection: $sort) {
      ForEach(Sort.allCases, id: \.self) { sort in
        Text(sort.title)
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
  SortPicker()
}
