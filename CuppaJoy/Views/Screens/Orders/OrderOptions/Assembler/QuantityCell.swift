//
//  CupCountCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

struct QuantityCell: View {
  @State private var quantity = 1
  
  var body: some View {
    HStack {
      Text("Quantity")
      Spacer()
      Button("-") {
        withAnimation { quantity -= 1 }
      }
      .disabled(quantity == 1)
      .buttonStyle(.bordered)
      
      Text("\(quantity)")
        .frame(minWidth: 20)
        .contentTransition(.numericText(value: Double(quantity)))
      
      Button("+") {
        withAnimation { quantity += 1 }
      }
      .disabled(quantity == 3)
      .buttonStyle(.bordered)
    }
    .font(.subheadline)
    .fontDesign(.monospaced)
    .foregroundStyle(.white)
  }
}

#Preview {
  QuantityCell()
}
