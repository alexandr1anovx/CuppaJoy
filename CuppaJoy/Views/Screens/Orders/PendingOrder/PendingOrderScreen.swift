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
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        pendingOrderList
        HStack {
          totalPriceLabel
          Spacer()
          paymentButton
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
  
  private var pendingOrderList: some View {
    List {
      PendingOrderCell()
        .swipeActions {
          Button("", systemImage: "trash") {
            // delete order
          }
          .tint(.pink)
        }
    }
    .shadow(radius: 10)
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollContentBackground(.hidden)
  }
  
  private var totalPriceLabel: some View {
    VStack(alignment: .center, spacing: 10) {
      Text("Total Price:")
        .font(.subheadline)
        .fontDesign(.monospaced)
        .foregroundStyle(.gray)
      Text("₴ 35.00")
        .font(.title2).bold()
        .foregroundStyle(.white)
    }
  }
  
  private var paymentButton: some View {
    Button {
      isShownPaymentScreen.toggle()
    } label: {
      Text("Go to Payment")
        .font(.callout).bold()
        .fontDesign(.monospaced)
        .foregroundStyle(.accent)
        .padding(10)
    }
    .buttonStyle(.borderedProminent)
    .tint(.black)
    .shadow(radius: 8)
  }
}

#Preview {
  PendingOrderScreen()
}
