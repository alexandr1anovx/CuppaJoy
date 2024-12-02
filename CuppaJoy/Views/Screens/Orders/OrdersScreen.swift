//
//  OrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 22.10.2024.
//

import SwiftUI

struct OrdersScreen: View {
    @Binding var isShownTabBar: Bool
    
    var body: some View {
        List {
            OrderCell(
                coffee: "Cappuccino",
                address: "3rd Slobidska",
                price: 35.00
            ).listRowBackground(Color.cstBlack)
            
            OrderCell(
                coffee: "Latte",
                address: "3rd Slobidska",
                price: 32.50
            ).listRowBackground(Color.cstBlack)
            
            OrderCell(
                coffee: "Espresso",
                address: "3rd Slobidska",
                price: 38.50
            )
            .listRowBackground(Color.cstBlack)
        }
        .shadow(radius: 10)
        .listRowSpacing(18)
        .scrollContentBackground(.hidden)
        .background(.cstBrown)
    }
}

#Preview {
    OrdersScreen(
        isShownTabBar: .constant(true)
    )
}
