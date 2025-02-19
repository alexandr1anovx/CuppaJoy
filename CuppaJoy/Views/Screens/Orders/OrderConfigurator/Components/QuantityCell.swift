//
//  CupCountCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

struct QuantityCell: View {
  @Binding var cupQuantity: Int
  
  var body: some View {
    HStack {
      Text("Quantity")
      Spacer()
      Button("-") {
        withAnimation { cupQuantity -= 1 }
      }
      .disabled(cupQuantity == 1)
      .buttonStyle(.bordered)
      
      Text("\(cupQuantity)")
        .frame(minWidth: 20)
        .contentTransition(.numericText(value: Double(cupQuantity)))
      
      Button("+") {
        withAnimation { cupQuantity += 1 }
      }
      .disabled(cupQuantity == 3)
      .buttonStyle(.bordered)
    }
    .font(.subheadline)
    .fontDesign(.monospaced)
    .foregroundStyle(.white)
  }
}

#Preview {
  QuantityCell(cupQuantity: .constant(1))
}
