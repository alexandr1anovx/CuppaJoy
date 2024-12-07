//
//  BaristaSelectionCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct BaristaCell: View {
  var body: some View {
    NavigationLink("Select a barista") {
      CoffeeOrderScreen()
    }
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .listRowBackground(Color.cstBrown)
  }
}
