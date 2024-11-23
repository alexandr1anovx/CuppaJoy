//
//  CompletedOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 27.10.2024.
//

import SwiftUI

struct CompletedOrderScreen: View {
    var body: some View {
        ZStack {
            Color.primaryBrown.ignoresSafeArea()
            VStack(spacing: 25) {
                Image("takeaway")
                    .foregroundStyle(.primaryReversed)
                
                Text("Ordered")
                    .font(.poppins(.medium, size: 22))
                
                VStack(alignment: .center, spacing: 50) {
                    Text("Alex, your order has been successfully placed.")
                        .foregroundStyle(.primaryGray)
                    
                    Text("The order will be ready today to 18:10 at the address Bradford BD1 1PR.")
                        .padding(.horizontal, 70)
                        .foregroundStyle(.primaryWhite)
                    
                    Text("Submit your personal QR code at a coffee shop to receive an order.")
                        .foregroundStyle(.primaryGray)
                    
                    
                }
                .font(.poppins(.regular, size: 15))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    CompletedOrderScreen()
}
