//
//  MyOrdersScreen.swift
//  CuppaJoy
//
//  Created by Alexander Andrianov on 03.01.2025.
//

import SwiftUI

enum OrderStatus: String, CaseIterable {
  case ongoing, received
  
  var title: String { rawValue.capitalized }
}

struct OrderStatusScreen: View {
  
  @State private var selectedStatus: OrderStatus = .ongoing
  @EnvironmentObject var orderViewModel: OrderViewModel
  
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
    .onAppear { selectedStatus = .ongoing }
  }
  
  private func indicatedTab(for status: OrderStatus, isSelected: Bool) -> some View {
    Text(status.title)
      .font(.subheadline)
      .fontWeight(.medium)
      .foregroundStyle(isSelected ? .csCream : .gray)
      .padding(10)
      .background(isSelected ? .black : .clear)
      .clipShape(.capsule)
  }
  
  private var orderStatusTabs: some View {
    HStack(spacing: 10) {
      ForEach(OrderStatus.allCases, id: \.self) { status in
        indicatedTab(for: status, isSelected: status == selectedStatus)
          .onTapGesture {
            withAnimation { selectedStatus = status }
          }
      }
    }
  }
  
  private var ongoingOrders: some View {
    List(orderViewModel.ongoingOrders, id: \.id) { order in
      OngoingOrderCell(order: order)
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(15)
    .scrollIndicators(.hidden)
    .scrollContentBackground(.hidden)
    .shadow(radius: 5)
  }
  
  private var receivedOrders: some View {
    List(orderViewModel.receivedOrders, id: \.id) { order in
      ReceivedOrderCell(order: order)
    }
    .listStyle(.insetGrouped)
    .listRowSpacing(15)
    .scrollIndicators(.hidden)
    .scrollContentBackground(.hidden)
    .shadow(radius: 5)
  }
}

#Preview {
  OrderStatusScreen()
    .environmentObject(OrderViewModel())
}
