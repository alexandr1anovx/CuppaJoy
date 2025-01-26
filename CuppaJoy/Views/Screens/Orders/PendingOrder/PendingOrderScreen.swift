//
//  OrdersConfirmationList.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 29.12.2024.
//

import SwiftUI

struct PendingOrderScreen: View {
  @State private var isShownPaymentScreen = false
  
  var body: some View {
    ZStack {
      Color.mainGradientBackground.ignoresSafeArea()
      
      VStack {
        List {
          PendingOrderCell()
            .swipeActions {
              Button("", systemImage: "trash") {
                // delete the order
              }
              .tint(.pink)
            }
        }
        .shadow(radius: 10)
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        
        Spacer()
        
        HStack {
          VStack(alignment: .leading, spacing: 8) {
            Text("Total Price")
              .font(.poppins(.medium, size: 15))
              .foregroundStyle(.gray)
            Text("UAH 35.00")
              .font(.poppins(.bold, size: 18))
              .foregroundStyle(.white)
          }
          
          Spacer()
          
          Button {
            isShownPaymentScreen = true
          } label: {
            Label("Next", systemImage: "cart.badge.plus")
              .font(.poppins(.bold, size: 15))
              .foregroundStyle(.white)
              .padding(10)
          }
          .tint(.black)
          .buttonStyle(.borderedProminent)
        }
        .padding(25)
      }
    }
    .navigationTitle("Pending Orders")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ReturnButton()
      }
    }
    .fullScreenCover(isPresented: $isShownPaymentScreen) {
      PaymentOptionScreen()
    }
  }
}

#Preview {
  PendingOrderScreen()
}
