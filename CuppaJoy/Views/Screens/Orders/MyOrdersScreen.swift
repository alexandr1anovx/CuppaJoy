//
//  OrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct MyOrdersScreen: View {
  @Binding var isShownTabBar: Bool
  
  var body: some View {
    List {
      FinishedOrderView(
        coffee: "Cappuccino",
        address: "3rd Slobidska",
        price: 35.00
      ).listRowBackground(Color.cstBlack)
      
      FinishedOrderView(
        coffee: "Latte",
        address: "3rd Slobidska",
        price: 32.50
      ).listRowBackground(Color.cstBlack)
      
      FinishedOrderView(
        coffee: "Espresso",
        address: "3rd Slobidska",
        price: 38.50
      ).listRowBackground(Color.cstBlack)
    }
    .listStyle(.insetGrouped)
    .shadow(radius: 5)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
    .background(.cstDarkBrown)
  }
}

#Preview {
  MyOrdersScreen(isShownTabBar: .constant(true))
}
