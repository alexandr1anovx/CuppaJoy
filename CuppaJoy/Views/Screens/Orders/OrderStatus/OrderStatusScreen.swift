//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

enum OrderStatus: String, CaseIterable {
  case ongoing = "Ongoing"
  case received = "Received"
}

struct OrderStatusScreen: View {
  @State private var selectedStatus = OrderStatus.ongoing
  
  var body: some View {
    ZStack {
      Color.appBackground.ignoresSafeArea(.all)
      VStack {
        orderStatusTabs
        if selectedStatus == .ongoing {
          ongoingOrders
        } else {
          receivedOrders
        }
      }.padding(.top)
    }
  }
  
  private func indicatedTab(title: String, isSelected: Bool) -> some View {
    Text(title)
      .font(.poppins(.medium, size: 14))
      .foregroundStyle(isSelected ? .white : .gray)
      .padding(10)
      .background(isSelected ? .csDesert : .clear)
      .clipShape(.capsule)
      .shadow(radius:8)
  }
  
  private var orderStatusTabs: some View {
    HStack(spacing:10) {
      ForEach(OrderStatus.allCases, id: \.self) { status in
        indicatedTab(
          title: status.rawValue,
          isSelected: status == selectedStatus
        )
        .onTapGesture {
          withAnimation(.spring) {
            selectedStatus = status
          }
        }
      }
    }
  }
  
  private var ongoingOrders: some View {
    List {
      OrderReceiptCell(
        coffee: .americano,
        address: "3rd Slobidska",
        price: 35.00
      )
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .scrollIndicators(.hidden)
    .scrollContentBackground(.hidden)
    .shadow(radius:8)
  }
  
  private var receivedOrders: some View {
    List {
      OrderReceiptCell(
        coffee: Coffee.cappuccino,
        address: "3rd Slobidska",
        price: 39.50
      )
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(20)
    .shadow(radius:8)
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  OrderStatusScreen()
}
