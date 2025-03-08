//
//  OrderComponentCountView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 21.02.2025.
//

import SwiftUI

struct OrderItemCounter: View {
  
  let title: String
  let minValue: Int
  let maxValue: Int
  @Binding var count: Int
  
  init(
    _ title: String,
    min: Int,
    max: Int,
    count: Binding<Int>
  ) {
    self.title = title
    self.minValue = min
    self.maxValue = max
    self._count = count
  }
  
  var body: some View {
    HStack {
      Text(title).font(.subheadline)
      Spacer()
      Button("-") { count -= 1 }
        .font(.footnote)
        .buttonStyle(.bordered)
        .clipShape(.circle)
        .disabled(count == minValue)
      Text("\(count)")
        .font(.subheadline)
        .frame(minWidth: 20)
        .animation(.bouncy, value: count)
        .contentTransition(.numericText())
      Button("+") { count += 1 }
        .font(.footnote)
        .buttonStyle(.bordered)
        .clipShape(.circle)
        .disabled(count == maxValue)
    }
    .fontWeight(.semibold)
    .foregroundStyle(.white)
  }
}

#Preview {
  OrderItemCounter(
    "Sugar Sticks:",
    min: 0,
    max: 2,
    count: .constant(2)
  )
}
