//
//  OrdersConfirmationList.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 29.12.2024.
//

import SwiftUI

struct ConfirmedOrderList: View {
  var body: some View {
    ZStack {
      Color.cstDarkBrown.ignoresSafeArea()
      
      VStack {
        List {
          ConfirmedOrderCell()
            .swipeActions {
              Button("", systemImage: "trash") {
                // delete the order
              }
              .tint(.pink)
            }
          ConfirmedOrderCell()
            .swipeActions {
              Button("", systemImage: "trash") {
                // delete the order
              }
              .tint(.pink)
            }
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(20)
        .scrollContentBackground(.hidden)
        .background(.cstDarkBrown)
        
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
    .navigationTitle("Orders")
    .navigationBarTitleDisplayMode(.inline)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        ArrowBackBtn()
      }
    }
  }
}

#Preview {
  ConfirmedOrderList()
}
