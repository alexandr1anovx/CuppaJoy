//
//  BaristaPicker.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 07.12.2024.
//

import SwiftUI

struct BaristaPicker: View {
  var body: some View {
    NavigationLink("Select a barista") {
      BaristaScreen()
    }
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .listRowBackground(Color.cstBrown)
  }
}

#Preview {
  BaristaPicker()
}
