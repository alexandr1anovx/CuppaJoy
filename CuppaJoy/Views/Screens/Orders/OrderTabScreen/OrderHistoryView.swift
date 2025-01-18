//
//  OrdersHistoryScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 28.12.2024.
//

import SwiftUI

struct OrderHistoryView: View {
  var body: some View {
    List {
      OrderReceiptCell(
        coffee: Coffee.cappuccino,
        address: "3rd Slobidska, 10",
        price: 39.50
      )
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  OrderHistoryView()
}
