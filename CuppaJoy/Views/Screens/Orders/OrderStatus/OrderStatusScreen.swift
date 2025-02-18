//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

enum OrderStatus: String, CaseIterable {
  case ongoing
  case received
  
  var title: String { self.rawValue.capitalized }
}

struct OrderStatusScreen: View {
  @State private var selectedStatus: OrderStatus = .ongoing
  
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
  
  private func indicatedTab(for status: OrderStatus, isSelected: Bool) -> some View {
    Text(status.title)
      .font(.subheadline)
      .fontDesign(.monospaced)
      .foregroundStyle(isSelected ? .csCream : .gray)
      .padding(10)
      .background(isSelected ? .black : .clear)
      .clipShape(.capsule)
      .shadow(radius: 5)
  }
  
  private var orderStatusTabs: some View {
    HStack(spacing: 10) {
      ForEach(OrderStatus.allCases, id: \.self) { status in
        indicatedTab(for: status, isSelected: status == selectedStatus)
          .onTapGesture {
            withAnimation {
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
    .shadow(radius: 8)
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
    .shadow(radius: 8)
    .scrollContentBackground(.hidden)
  }
}

#Preview {
  OrderStatusScreen()
}
