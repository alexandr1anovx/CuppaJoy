//
//  OrdersConfirmationList.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 29.12.2024.
//

import SwiftUI

struct PendingOrderScreen: View {
  @State private var isShownPaymentScreen: Bool = false
  
  var body: some View {
    ZStack {
      Color.mainBackgroundGradient.ignoresSafeArea()
      
      VStack {
        List {
          PendingOrderCell()
            .swipeActions {
              Button("", systemImage: "trash") {
                // delete the order
              }
              .tint(.red)
            }
          PendingOrderCell()
            .swipeActions {
              Button("", systemImage: "trash") {
                // delete the order
              }
              .tint(.red)
            }
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        
        Spacer()
        
        HStack {
          VStack(alignment: .leading, spacing: 8) {
            Text("Total Price")
              .font(.poppins(.medium, size: 15))
              .foregroundStyle(.cstGray)
            Text("UAH 35.00")
              .font(.poppins(.bold, size: 18))
              .foregroundStyle(.cstWhite)
          }
          
          Spacer()
          
          
          Button {
            // action
            isShownPaymentScreen.toggle()
          } label: {
            Label("Next", systemImage: "cart.badge.plus")
              .font(.poppins(.medium, size: 16))
              .foregroundStyle(.cstDarkBrown)
              .padding(5)
          }
          .tint(Color.cstCream)
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
      PaymentScreen()
    }
  }
}

#Preview {
  PendingOrderScreen()
}
