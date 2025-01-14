//
//  CupSizeCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

struct CupSizeCell: View {
  @State private var selectedSize: CoffeeCup = .small
  
  var body: some View {
    VStack(alignment: .leading) {
      
      Text("Size:")
        .font(.poppins(.medium, size: 15))
        .foregroundStyle(.cstWhite)
      
      Picker("", selection: $selectedSize) {
        ForEach(CoffeeCup.allCases, id: \.self) { size in
          Text(size.rawValue.capitalized)
        }
      }
      .pickerStyle(.segmented)
      .colorMultiply(.accent)
    }
    .listRowBackground(Color.cstBrown)
  }
}
