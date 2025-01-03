//
//  OrderPaymentView.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 02.01.2025.
//

import SwiftUI

struct PaymentMethodsContainer: View {
  var body: some View {
    ZStack {
      
      RoundedRectangle(cornerRadius: 25)
        .fill(Color.cstDarkBrown)
        .ignoresSafeArea()
      
      VStack(alignment: .leading) {
        
        VStack(alignment: .leading, spacing: 40) {
          Text("Order Payment")
            .font(.poppins(.bold, size: 18))
            .foregroundStyle(.cstWhite)
          
          HStack(spacing: 15) {
            Image(systemName: "cart.badge.plus")
              .resizable()
              .scaledToFit()
              .frame(maxHeight: 22)
              .foregroundStyle(.cstDarkBrown)
              .padding(8)
              .background(
                RoundedRectangle(cornerRadius: 10)
                  .fill(Color.cstCream)
              )
            
            VStack(alignment: .leading, spacing: 8) {
              Text("Alexander")
                .font(.poppins(.medium, size: 15))
                .foregroundStyle(.cstWhite)
              Text("Magic Coffee store: Bradford BD1 1PR")
                .font(.poppins(.regular, size: 12))
                .foregroundStyle(.cstCream)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            }
          }
        }
        .padding(.top, 25)
        .padding(.horizontal, 25)
        
        List {
          PaymentMethodCell()
            .listRowBackground(Color.cstBlack)
        }
        .listStyle(.sidebar)
        .scrollContentBackground(.hidden)
        
        Spacer()
        
        TotalPriceView()
          .padding(25)
        
      }
    }
  }
}

#Preview {
  PaymentMethodsContainer()
}
