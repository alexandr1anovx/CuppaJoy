//
//  OrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OngoingOrdersScreen: View {
  @Binding var isTabBarVisible: Bool
  
  var body: some View {
    List {
      OrderReceiptCell(
        coffee: Coffee.americano,
        address: "3rd Slobidska",
        price: 35.00
      ).listRowBackground(Color.cstBlack)
      
      OrderReceiptCell(
        coffee: Coffee.latte,
        address: "3rd Slobidska",
        price: 32.50
      ).listRowBackground(Color.cstBlack)
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
    .background(.cstDarkBrown)
  }
}

#Preview {
  OngoingOrdersScreen(isTabBarVisible: .constant(true))
}
