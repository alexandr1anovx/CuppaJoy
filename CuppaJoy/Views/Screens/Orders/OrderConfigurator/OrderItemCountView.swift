//
//  OrderComponentCountView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.02.2025.
//

import SwiftUI

struct OrderItemCountView: View {
  
  // MARK: Properties
  let itemName: String
  let minValue: Int
  let maxValue: Int
  @Binding var count: Int
  
  // MARK: Initializer
  init(
    _ itemName: String,
    min: Int,
    max: Int,
    count: Binding<Int>) {
      self.itemName = itemName
      self.minValue = min
      self.maxValue = max
      self._count = count
    }
  
  var body: some View {
    HStack {
      Text(itemName).font(.callout)
      
      Spacer()
      
      Button("-") {
        withAnimation { count -= 1 }
      }
      .font(.footnote)
      .buttonStyle(.bordered)
      .disabled(count == minValue)
      
      Text("\(count)")
        .font(.callout)
        .frame(minWidth: 25)
        .contentTransition(.numericText())
      
      Button("+") {
        withAnimation { count += 1 }
      }
      .font(.footnote)
      .buttonStyle(.bordered)
      .disabled(count == maxValue)
    }
    .fontWeight(.medium)
    .foregroundStyle(.white)
    .listRowInsets(
      EdgeInsets(
        top: 28,
        leading: 18,
        bottom: 22,
        trailing: 18
      )
    )
  }
}

#Preview {
  OrderItemCountView(
    "Sugar Sticks:",
    min: 0,
    max: 2,
    count: .constant(2)
  )
}
