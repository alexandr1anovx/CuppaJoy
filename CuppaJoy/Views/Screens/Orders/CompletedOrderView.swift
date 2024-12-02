//
//  CompletedOrderScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 27.10.2024.
//

import SwiftUI

struct CompletedOrderView: View {
    var body: some View {
        ZStack {
            Color.cstDarkBrown.ignoresSafeArea()
            VStack(spacing: 15) {
                
                Image("takeaway")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .foregroundStyle(.cstCream)
                Text("Order accepted!")
                    .font(.poppins(.bold, size: 20))
                    .foregroundStyle(.cstCream)
                
                VStack(alignment: .center) {
                    Text("The order will be ready today to 18:10 at the address Bradford BD1 1PR.")
                        .foregroundStyle(.cstCream)
                    
                        .padding(.vertical, 35)
                    
                    Text("Submit your personal QR code at the coffee shop to receive an order.")
                        .foregroundStyle(.cstGray)
                }
                .font(.poppins(.regular, size: 14))
                .padding(.horizontal, 30)
                .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    CompletedOrderView()
}
