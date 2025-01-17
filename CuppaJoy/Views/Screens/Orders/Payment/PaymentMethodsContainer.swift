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
        .fill(Color.mainBackgroundGradient)
        .ignoresSafeArea()
      
      VStack {
        PaymentScreenHeaderView()
        PaymentMethodCell()
        Spacer()
        
        HStack {
          VStack(alignment: .leading, spacing: 5) {
            Text("Total Price")
              .font(.poppins(.medium, size: 13))
              .foregroundStyle(.gray)
            Text("UAH 35.00")
              .font(.poppins(.bold, size: 17))
              .foregroundStyle(.white)
          }
          
          Spacer()
          
          Button {
            // ...
          } label: {
            Label("Pay", systemImage: "apple.logo")
              .font(.title3)
              .fontWeight(.medium)
              .foregroundStyle(.white)
              .padding(8)
          }
          .tint(.black)
          .buttonStyle(.borderedProminent)
        }
        .padding(25)
      }
      .padding(.top)
    }
  }
}

#Preview {
  PaymentMethodsContainer()
}

struct PaymentScreenHeaderView: View {
  var body: some View {
    VStack(alignment: .center, spacing: 30) {
      
      Text("Order Payment")
        .font(.poppins(.bold, size: 17))
        .foregroundStyle(.white)
      
      HStack(spacing: 15) {
        Image(.man)
          .foregroundStyle(.csDarkBrown)
          .padding(8)
          .background(
            RoundedRectangle(cornerRadius: 10)
              .fill(Color.accent)
          )
        
        VStack(alignment: .leading, spacing: 5) {
          Text("Alexander")
            .font(.poppins(.bold, size: 15))
            .foregroundStyle(.white)
          Text("Magic Coffee store: Bradford BD1 1PR")
            .font(.poppins(.medium, size: 12))
            .foregroundStyle(.gray)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
        }
        Spacer()
      }
      .padding(.horizontal,25)
    }
  }
}
