//
//  AdditivePicker.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 20.02.2025.
//

import SwiftUI

struct OrderItemPickerView<T: OrderItemType>: View {
  
  let name: String
  @Binding var selectedItem: T
  let items = Array(T.allCases)
  
  init(_ name: String, selectedItem: Binding<T>) {
    self.name = name
    self._selectedItem = selectedItem
  }
  
  var body: some View {
    Picker(name, selection: $selectedItem) {
      ForEach(items, id: \.self) { item in
        Text(item.title)
          .tag(item)
      }
    }
    .tint(.csCream)
    .font(.callout)
    .fontWeight(.medium)
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
  OrderItemPickerView(
    "Milk",
    selectedItem: .constant(Milk.cow)
  )
}
