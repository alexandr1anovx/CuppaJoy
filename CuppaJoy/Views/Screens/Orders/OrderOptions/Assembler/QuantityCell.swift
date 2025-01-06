//
//  CupCountCell.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 06.01.2025.
//

import SwiftUI

struct QuantityCell: View {
  @State private var quantity: Int = 1
  
  var body: some View {
    HStack {
      Text("Quantity")
      
      Spacer()
      
      Button("-") {
        withAnimation { quantity -= 1 }
      }
      .tint(.cstBlack)
      .disabled(quantity == 1)
      .buttonStyle(.bordered)
      
      Text("\(quantity)")
        .frame(minWidth: 20)
        .contentTransition(.numericText(value: Double(quantity)))
      
      Button("+") {
        withAnimation { quantity += 1 }
      }
      .tint(.cstBlack)
      .disabled(quantity == 5)
      .buttonStyle(.bordered)
    }
    .font(.poppins(.medium, size: 15))
    .foregroundStyle(.cstWhite)
    .listRowBackground(Color.cstBrown)
  }
}

#Preview {
  QuantityCell()
}
