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
        ZStack {
            Color.primarySystem.ignoresSafeArea()
            VStack {
                Image("orders")
                Text("Orders")
                    .font(.poppins(.medium, size: 25))
            }
        }
    }
}

#Preview {
    OrdersScreen(isShownTabBar: .constant(true))
}
