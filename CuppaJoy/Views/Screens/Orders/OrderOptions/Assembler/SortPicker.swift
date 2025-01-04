//
//  SortSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

enum Sort: String, CaseIterable {
  case santos = "Santos"
  case bourbonSantos = "Bourbon Santos"
  case minas = "Minas"
  case rio = "Rio"
  case canilon = "Canilon"
  case flatBeat = "Flat Beat"
}

struct SortPicker: View {
  @State private var sort: Sort = .santos
  
  var body: some View {
    Picker("Sort", selection: $sort) {
      ForEach(Sort.allCases, id: \.self) { sort in
        Text(sort.rawValue)
      }
    }
    .pickerStyle(.menu)
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .tint(.cstCream)
    .listRowBackground(Color.cstBrown)
  }
}

#Preview {
  SortPicker()
}
