//
//  OrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrderOngoingView: View {
  var body: some View {
    List {
      OrderReceiptCell(
        coffee: .americano,
        address: "3rd Slobidska",
        price: 35.00
      )
      OrderReceiptCell(
        coffee: .latte,
        address: "3rd Slobidska",
        price: 32.50
      )
      OrderReceiptCell(
        coffee: .americano,
        address: "3rd Slobidska",
        price: 35.00
      )
      OrderReceiptCell(
        coffee: .latte,
        address: "3rd Slobidska",
        price: 32.50
      )
    }
    .padding(.bottom)
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollIndicators(.hidden)
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  OrderOngoingView()
}
