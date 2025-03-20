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
  
  var title: String { rawValue.capitalized }
  var iconName: String {
    switch self {
    case .ongoing: "cart.badge.clock"
    case .received: "cart.fill"
    }
  }
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
    .onAppear {
      selectedStatus = .ongoing
      orderViewModel.getOngoingOrders()
      orderViewModel.getReceivedOrders()
    }
  }
  
  private func indicatedTab(for status: OrderStatus, isSelected: Bool) -> some View {
    Label(status.title, systemImage: status.iconName)
      .font(.subheadline)
      .fontWeight(.semibold)
      .foregroundStyle(isSelected ? .orange : .gray)
      .padding(10)
      .background(isSelected ? .csDarkGrey : .clear)
      .clipShape(.capsule)
  }
  
  private var orderStatusTabs: some View {
    HStack(spacing: 8) {
      ForEach(OrderStatus.allCases, id: \.self) { status in
        indicatedTab(for: status, isSelected: status == selectedStatus)
          .onTapGesture { selectedStatus = status }
      }
    }
  }
  
  @ViewBuilder
  private var ongoingOrders: some View {
    if orderViewModel.ongoingOrders.count == 0 {
      ContentUnavailableView {
        Label("Ongoing Orders", systemImage: "text.badge.xmark")
      } description: {
        Text("You don't have any ongoing orders yet.")
      } actions: {
        NavigationLink {
          HomeScreen()
        } label: {
          Label("Add", systemImage: "plus.circle.fill")
            .foregroundStyle(.orange)
            .font(.subheadline)
            .fontWeight(.semibold)
            .padding(13)
            .background(.csDarkGrey)
            .clipShape(.buttonBorder)
        }

      }
    } else {
      List(orderViewModel.ongoingOrders, id: \.id) { order in
        OngoingOrderCell(order: order)
      }
      .listStyle(.insetGrouped)
      .listRowSpacing(15)
      .scrollIndicators(.hidden)
      .scrollContentBackground(.hidden)
      .shadow(radius: 5)
    }
  }
  
  @ViewBuilder
  private var receivedOrders: some View {
    if orderViewModel.receivedOrders.count == 0 {
      ContentUnavailableView(
        "Received Orders",
        systemImage: "text.badge.xmark" ,
        description: Text("You don't have any received orders yet.")
      )
    } else {
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
}

#Preview {
  OrderStatusScreen()
    .environmentObject( OrderViewModel() )
}
