//
//  TypeSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct CoffeeTypeCell: View {
  @State private var value: Double = 0.0
  
  var body: some View {
    HStack(spacing: 50) {
      Text("Type")
        .foregroundStyle(.cstWhite)
        .font(.poppins(.medium, size: 15))
      VStack {
        Slider(value: $value, in: 0...1)
          .tint(.cstCream)
        HStack {
          Text("Arabica")
          Spacer()
          Text("Robusta")
        }
        .foregroundStyle(.cstCream)
        .font(.poppins(.regular, size: 13))
      }
    }
    .listRowBackground(Color.cstBrown)
  }
}
