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
      .listRowBackground(Color.black)
      
      OrderReceiptCell(
        coffee: .latte,
        address: "3rd Slobidska",
        price: 32.50
      )
      .listRowBackground(Color.black)
      
      OrderReceiptCell(
        coffee: .americano,
        address: "3rd Slobidska",
        price: 35.00
      )
      .listRowBackground(Color.black)
      
      OrderReceiptCell(
        coffee: .latte,
        address: "3rd Slobidska",
        price: 32.50
      )
      .listRowBackground(Color.black)
    }
    .padding(.bottom)
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  OrderOngoingView()
}
